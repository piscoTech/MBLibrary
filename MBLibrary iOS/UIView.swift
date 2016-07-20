//
//  UIView.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

extension UIView {
	
	public func shake() {
		let animation = shakingAnimation
		self.layer.add(animation, forKey: nil)
	}
	
}
