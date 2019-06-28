//
//  InAppPurchaseManager.swift
//  MBLibrary
//
//  Created by Marco Boschi on 05/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation
import StoreKit

public struct TransactionStatus {
	
	/// The product identifier the transaction referes to.
	public let product: String
	/// The status of the transaction.
	public let status: MBPaymentTransactionState
	/// If the transaction has status `.failed` the error, `nil` otherwise.
	public let error: Error?
	
}

public struct RestorationStatus {
	
	/// Whether or not the restoration process was successful.
	public let success: Bool
	/// In case of success the number of restored transactions, `nil` otherwise.
	public let restored: Int?
	/// The error in case of failure, `nil` otherwise.
	public let error: Error?
	
}

public enum MBPaymentTransactionState {
	/// Tha transaction is completed as the payment has been finished.
	case purchased
	/// The transaction is completed as the purchase has been restored.
	case restored
	/// Tha transaction has somehow failed.
	case failed
	/// The transaction has been deferred waiting for approval by family manager, any modal view locking the app should be dismissed while waiting for `failed` or `completed` status.
	case deferred
	
	public func isSuccess() -> Bool {
		return self == .purchased || self == .restored
	}
}

public class InAppPurchaseManager: NSObject {
	
	public static let transactionNotification = NSNotification.Name("MBLibraryIAPManagerTransactionNotification")
	public static let restoreNotification = NSNotification.Name("MBLibraryIAPManagerRestoreNotification")
	
	public static let defaultsKeyPrefix = "iapStatus_"
	public fileprivate(set) var areProductsLoaded = false
	
	fileprivate let defaults: KeyValueStore
	fileprivate var productsStatus: [String: (purchased: Bool, product: SKProduct?)]
	
	fileprivate var productsRequest: SKProductsRequest?
	fileprivate var productsRequestHandler: ((_ success: Bool, _ products: [SKProduct]?) -> ())?
	
	fileprivate var restoredTransaction = 0
	
	override private init() {
		fatalError("Use the public init method.")
	}
	
	convenience public init(productIds: Set<String>, inUserDefaults defaults: UserDefaults) {
		self.init(productIds: productIds, inUserDefaults: KeyValueStore(userDefaults: defaults))
	}
	
	public init(productIds: Set<String>, inUserDefaults defaults: KeyValueStore) {
		self.defaults = defaults
		productsStatus = [:]

		super.init()
		
		SKPaymentQueue.default().add(self)
		for pId in productIds {
			productsStatus[pId] = (defaults.bool(forKey: InAppPurchaseManager.defaultsKeyPrefix + pId), nil)
		}
	}
	
	public func loadProducts(completion: ((_ success: Bool, _ products: [SKProduct]?) -> ())?) {
		productsRequest?.cancel()
		productsRequestHandler = completion

		productsRequest = SKProductsRequest(productIdentifiers: Set(productsStatus.keys))
		productsRequest!.delegate = self
		productsRequest!.start()
	}
	
	/// Check if the specified product has been purchased.
	///
	/// - parameter pId: The product identifier of the product to check.
	///
	/// - returns: Whether or not the product has been purchased, at least once in case of consumable.
	public func isProductPurchased(pId: String) -> Bool {
		return productsStatus[pId]?.purchased ?? false
	}
	
	/// Check if the specified product has been purchased.
	///
	/// - parameter product: The product to check.
	///
	/// - returns: Whether or not the product has been purchased, at least once in case of consumable.
	public func isProductPurchased(product: SKProduct) -> Bool {
		return isProductPurchased(pId: product.productIdentifier)
	}
	
	public var canMakePayments: Bool {
		return SKPaymentQueue.canMakePayments()
	}
	
	///Initialize the transaction for buying the specified product.
	///
	///Listen to `InAppPurchaseManager.transactionNotification` notification to receive feedback on the transaction as `TransactionStatus` in the notification object.
	///- returns: Whether or not the specified product identifier exist and the payment has been initialized.
	public func buyProduct(pId: String) -> Bool {
		guard let (_, tmp) = productsStatus[pId], let p = tmp else {
			return false
		}
		
		buyProduct(product: p)
		return true
	}
	
	///Initialize the transaction for buying the specified product.
	///
	///Listen to `InAppPurchaseManager.transactionNotification` notification to receive feedback on the transaction as `TransactionStatus` in the notification object.
	public func buyProduct(product: SKProduct) {
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
	}
	
	///Initialize restore process for previous purchases.
	///
	///Listen to `InAppPurchaseManager.restoreNotification` notification to receive the result of the process stored as `RestorationStatus` in the notification object.
	public func restorePurchases() {
		restoredTransaction = 0
		SKPaymentQueue.default().restoreCompletedTransactions()
	}
	
	class func shouldDisplayError(for e: Error) -> Bool {
		let err = e as NSError
		
		// No need to display any error if the payment was cancelled.
		return err.code != SKError.Code.paymentCancelled.rawValue
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
		
		productsRequestHandler?(true, products)
		clearRequestAndHandler()
	}
	
	public func request(_ request: SKRequest, didFailWithError error: Error) {
		productsRequestHandler?(false, nil)
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
			case .failed:
				failed(transaction)
			case .restored:
				restore(transaction)
			case .deferred:
				updateTransaction(for: transaction.payment.productIdentifier, withStatus: .deferred)
			case .purchasing:
				fallthrough
			default:
				break
			}
		}
	}
	
	public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
		NotificationCenter.default.post(name: InAppPurchaseManager.restoreNotification, object: RestorationStatus(success: true, restored: restoredTransaction, error: nil))
	}
	
	public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
		NotificationCenter.default.post(name: InAppPurchaseManager.restoreNotification, object: RestorationStatus(success: false, restored: nil, error: error))
	}
	
	private func complete(_ transaction: SKPaymentTransaction) {
		updateTransaction(for: transaction.payment.productIdentifier, withStatus: .purchased)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func restore(_ transaction: SKPaymentTransaction) {
		guard let productIdentifier = transaction.original?.payment.productIdentifier else {
			return
		}
		
		restoredTransaction += 1
		updateTransaction(for: productIdentifier, withStatus: .restored)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func failed(_ transaction: SKPaymentTransaction) {
		updateTransaction(for: transaction.payment.productIdentifier, withStatus: .failed, andError: transaction.error)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
	
	private func updateTransaction(for product: String, withStatus status: MBPaymentTransactionState, andError error: Error? = nil) {
		precondition(error != nil || status != .failed, "Missing error")
		
		if status.isSuccess() {
			productsStatus[product]?.purchased = true
			defaults.set(true, forKey: InAppPurchaseManager.defaultsKeyPrefix + product)
			defaults.synchronize()
		}
		
		NotificationCenter.default.post(name: InAppPurchaseManager.transactionNotification, object: TransactionStatus(product: product, status: status, error: status == .failed ? error : nil))
	}
	
}
