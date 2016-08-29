//
//  UIAlertController.swift
//  MBLibrary
//
//  Created by Marco Boschi on 07/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

extension UIAlertController {
	
	convenience public init(simpleAlert title: String, message: String?) {
		self.init(title: title, message: message, preferredStyle: .alert)
		
		let ok = UIAlertAction(title: MBLocalizedString("OK", comment: "Ok"), style: .cancel) { (_) in
			self.dismiss(animated: true, completion: nil)
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
		var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[loading]-(20)-|", options: [], metrics: nil, views: views)
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[loading]|", options: [], metrics: nil, views: views)
		pending.view.addConstraints(constraints)
		
		loading.isUserInteractionEnabled = false
		loading.startAnimating()
		
		return pending
	}

}
