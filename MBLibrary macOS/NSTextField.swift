//
//  NSTextField.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Cocoa

extension NSTextField {
	
	public func setStringValueAnimated(_ newValue: String, withColor color: NSColor?) {
		let time: TimeInterval = 0.2
		
		if stringValue == newValue {
			return
		}
		
		NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext) -> Void in
			context.duration = time / 2
			context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
			self.animator().alphaValue = 0
			}, completionHandler: { () -> Void in
				self.stringValue = newValue
				if color != nil {
					self.textColor = color
				}
				NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext) -> Void in
					context.duration = time / 2
					context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
					self.animator().alphaValue = 1
					}, completionHandler: nil)
		})
	}
}
