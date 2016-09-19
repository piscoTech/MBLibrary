//
//  OutlinedLabel.swift
//  MBLibrary
//
//  Created by Marco Boschi on 18/09/2016.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

@IBDesignable
class OutlinedLabel: UILabel {

	@IBInspectable var outlineWidth: CGFloat = 1 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	@IBInspectable var outlineColor: UIColor = .white {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override func drawText(in rect: CGRect) {
		let strokeTextAttributes: [String : Any] = [
			NSStrokeColorAttributeName : outlineColor,
			NSStrokeWidthAttributeName : -outlineWidth
		]
		
		let oldText = self.attributedText
		
		let renderText = (oldText ?? NSAttributedString(string: "")).mutableCopy() as! NSMutableAttributedString
		renderText.addAttributes(strokeTextAttributes, range: NSRange(location: 0, length: renderText.length))
		
		self.attributedText = renderText
		super.drawText(in: rect)
		
		self.attributedText = oldText
	}
	
}
