//
//  PopoverController.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

public class PopoverController: NSObject, UIPopoverPresentationControllerDelegate {
	
	private static let ctrl = PopoverController()
	
	private override init() {}
	
	public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.none
	}
	
	@nonobjc public class func preparePresentation(for vc: UIViewController) {
		vc.modalPresentationStyle = UIModalPresentationStyle.popover
		let popover = vc.popoverPresentationController!
		popover.delegate = ctrl
	}
	
}
