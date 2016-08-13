//
//  InAppPurchaseManager.swift
//  MBLibrary
//
//  Created by Marco Boschi on 05/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation
import StoreKit

public typealias ProductTransactionHandler = (success: Bool, error: NSError?) -> ()

public class InAppPurchaseManager: NSObject {
	
	public static let defaultsKeyPrefix = "iapStatus_"
	public private(set) var areProductsLoaded = false
	
	private let defaults: KeyValueStore
	private var productsStatus: [String: (purchased: Bool, product: SKProduct?)]
	
	private var productsRequest: SKProductsRequest?
	
	private var productsRequestHandler: ((success: Bool, products: [SKProduct]?) -> ())?
	private var buyCompletionHandler: [String: (success: Bool, error: NSError?) -> ()] = [:]
	private var restoreProcessHandler: ((success: Bool, restored: Int?, error: NSError?) -> ())?
	
	private var restoredTransaction = 0
	
	override private init() {
		fatalError("Use the public init method.")
	}
	
	convenience public init(productIds: Set<String>, inUserDefaults defaults: UserDefaults) {
		self.init(productIds: productIds, inUserDefaults: KeyValueStore(userDefaults: defaults))
	}
	
	public init(productIds: Set<String>, inUserDefaults defaults: KeyValueStore) {
		self.defaults = defaults
		
		productsStatus = [:]
		for pId in productIds {
			productsStatus[pId] = (defaults.bool(forKey: InAppPurchaseManager.defaultsKeyPrefix + pId), nil)
		}
		
		super.init()
		
		SKPaymentQueue.default().add(self)
	}
	
	public func loadProducts(completion: ((success: Bool, products: [SKProduct]?) -> ())?) {
		productsRequest?.cancel()
		productsRequestHandler = completion

		productsRequest = SKProductsRequest(productIdentifiers: Set(productsStatus.keys))
		productsRequest!.delegate = self
		productsRequest!.start()
	}
	
	public func isProductPurchased(pId: String) -> Bool {
		return productsStatus[pId]?.purchased ?? false
	}
	
	public func isProductPurchased(product: SKProduct) -> Bool {
		return isProductPurchased(pId: product.productIdentifier)
	}
	
	public var canMakePayments: Bool {
		return SKPaymentQueue.canMakePayments()
	}
	
	///- returns: Whether or not the specified productID exist and the payment has been initialized.
	@discardableResult
	public func buyProduct(pId: String, completion: ProductTransactionHandler?) -> Bool {
		guard let (_, tmp) = productsStatus[pId], let p = tmp else {
			return false
		}
		
		buyProduct(product: p, completion: completion)
		return true
	}
	
	public func buyProduct(product: SKProduct, completion: ProductTransactionHandler?) {
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
		
		buyCompletionHandler[product.productIdentifier] = completion
	}
	
	///Initialize restore process for previous purchases.
	///- parameter requestCompletion: This block is called upon error on restoring purchases or if there are no purchase to restore, if some purchases are restored the appropriate callback block will be called (if present).
	///- parameter success: Set to `true` if the restoration process was successful, `false` otherwise.
	///- parameter restored: If the restoration was successful will hold the number of restored transaction, `nil` otherwise.
	///- parameter error: The error in case of failure of the restoration process, `nil` otherwise.
	///- parameter productCompletion: The callback block to be called after each purchases, identified by its productId as the key, is completed.
	public func restorePurchases(requestCompletion: ((success: Bool, restored: Int?, error: NSError?) -> ())?, productCompletion: [String: ProductTransactionHandler]?) {
		restoreProcessHandler = requestCompletion
		buyCompletionHandler += productCompletion ?? [:]
		restoredTransaction = 0
		SKPaymentQueue.default().restoreCompletedTransactions()
	}
	
}

// MARK: - Product request delegate methods

extension InAppPurchaseManager: SKProductsRequestDelegate {
	
	public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		let products = response.products
		
		for p in products {
			productsStatus[p.productIdentifier]?.product = p
		}
		
		areProductsLoaded = true
		
		productsRequestHandler?(success: true, products: products)
		clearRequestAndHandler()
	}
	
	public func request(_ request: SKRequest, didFailWithError error: NSError) {
		productsRequestHandler?(success: false, products: nil)
		clearRequestAndHandler()
	}
	
	private func clearRequestAndHandler() {
		productsRequest = nil
		productsRequestHandler = nil
	}
	
}

// MARK: - Transaction observer methods

extension InAppPurchaseManager: SKPaymentTransactionObserver {
	
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction in transactions {
			switch (transaction.transactionState) {
			case .purchased:
				complete(transaction)
				break
			case .failed:
				failed(transaction)
				break
			case .restored:
				restore(transaction)
				break
			case .deferred:
				break
			case .purchasing:
				break
			}
		}
	}
	
	public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
		restoreProcessHandler?(success: true, restored: restoredTransaction, error: nil)
		restoreProcessHandler = nil
	}
	
	public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: NSError) {
		restoreProcessHandler?(success: false, restored: nil, error: error)
		restoreProcessHandler = nil
	}
	
	private func complete(_ transaction: SKPaymentTransaction) {
		finishTrasactionFor(transaction.payment.productIdentifier)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func restore(_ transaction: SKPaymentTransaction) {
		guard let productIdentifier = transaction.original?.payment.productIdentifier else {
			return
		}
		
		restoredTransaction += 1
		finishTrasactionFor(productIdentifier)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func failed(_ transaction: SKPaymentTransaction) {
		finishTrasactionFor(transaction.payment.productIdentifier, withError: transaction.error)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func finishTrasactionFor(_ identifier: String, withError error: NSError? = nil) {
		if error == nil {
			productsStatus[identifier]?.purchased = true
			defaults.set(true, forKey: InAppPurchaseManager.defaultsKeyPrefix + identifier)
			defaults.synchronize()
		}
		
		buyCompletionHandler[identifier]?(success: error == nil, error: error)
		buyCompletionHandler[identifier] = nil
	}
}
