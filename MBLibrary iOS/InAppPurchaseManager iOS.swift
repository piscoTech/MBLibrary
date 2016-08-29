//
//  InAppPurchaseManager iOS.swift
//  MBLibrary
//
//  Created by Marco Boschi on 13/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit
import StoreKit

extension InAppPurchaseManager {
	
	public class func getProductListError() -> UIAlertController {
		return UIAlertController(simpleAlert: MBLocalizedString("ERROR_PURCHASE", comment: "Error"), message: MBLocalizedString("ERROR_PROD_LIST", comment: "Product list"))
	}
	
	public class func getAlert(forError error: Error) -> UIAlertController? {
		let err = error as NSError
		guard err.code != SKError.Code.paymentCancelled.rawValue else {
			// No need to display any error if the payment was cancelled.
			return nil
		}

		return UIAlertController(simpleAlert: MBLocalizedString("ERROR_PURCHASE", comment: "Error"), message: error.localizedDescription)
	}
	
}
