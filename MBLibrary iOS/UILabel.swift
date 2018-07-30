//
//  UILabel.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

extension UILabel {
	
	public func setStringValueAnimated(_ newValue: String, withColor color: UIColor?) {
		let time: TimeInterval = 0.2
		
		if text == newValue {
			return
		}
		
		let animation = CATransition()
		animation.duration = time
		animation.type = .fade
		animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		self.layer.add(animation, forKey: "changeTextTransition")
		
		self.text = newValue
		if color != nil {
			self.textColor = color
		}
	}
	
}
