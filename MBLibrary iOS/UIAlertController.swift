//
//  UIAlertController.swift
//  MBLibrary
//
//  Created by Marco Boschi on 07/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

extension UIAlertController {
	
	convenience public init(simpleAlert title: String, message: String?, completion: (() -> Void)? = nil) {
		self.init(title: title, message: message, preferredStyle: .alert)
		
		let ok = UIAlertAction(title: MBLocalizedString("OK", comment: "Ok"), style: .cancel) { (_) in
			self.dismiss(animated: true, completion: nil)
			completion?()
		}
		self.addAction(ok)
	}

	public class func getModalLoading() -> UIAlertController {
		let pending = UIAlertController(title: nil, message: "", preferredStyle: .alert)
		
		let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		loading.translatesAutoresizingMaskIntoConstraints = false
		loading.color = .gray
		pending.view.addSubview(loading)
		
		let views = ["loading": loading]
		let space: [String: CGFloat] = ["p" : 20]
		var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(p)-[loading]-(p)-|", options: [], metrics: space, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[loading]|", options: [], metrics: nil, views: views)
		pending.view.addConstraints(constraints)
		
		loading.isUserInteractionEnabled = false
		loading.startAnimating()
		
		return pending
	}
	
	public class func getModalProgress() -> (alert: UIAlertController, bar: UIProgressView) {
		let progress = UIAlertController(title: nil, message: "", preferredStyle: .alert)
		
		let bar = UIProgressView()
		bar.translatesAutoresizingMaskIntoConstraints = false
		bar.trackTintColor = .lightGray
		progress.view.addSubview(bar)
		
		let views = ["loading": bar]
		var space: [String: CGFloat] = ["p" : 30]
		var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(p)-[loading]-(p)-|", options: [], metrics: space, views: views)
		space = ["p" : 20]
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(p)-[loading]-(p)-|", options: [], metrics: space, views: views)
		progress.view.addConstraints(constraints)
		
		return (progress, bar)
	}

}
