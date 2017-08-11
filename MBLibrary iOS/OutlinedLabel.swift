//
//  OutlinedLabel.swift
//  MBLibrary
//
//  Created by Marco Boschi on 18/09/2016.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

@IBDesignable
public class OutlinedLabel: UILabel {

	@IBInspectable public var outlineWidth: CGFloat = 1 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	@IBInspectable public var outlineColor: UIColor = .white {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override public func drawText(in rect: CGRect) {
		let strokeTextAttributes: [NSAttributedStringKey : Any] = [
			.strokeColor : outlineColor,
			.strokeWidth : -outlineWidth
			]
		
		let oldText = self.attributedText
		
		let renderText = (oldText ?? NSAttributedString(string: "")).mutableCopy() as! NSMutableAttributedString
		renderText.addAttributes(strokeTextAttributes, range: NSRange(location: 0, length: renderText.length))
		
		self.attributedText = renderText
		super.drawText(in: rect)
		
		self.attributedText = oldText
	}
	
}
