//
//  VariableToolbar.swift
//  MBLibrary
//
//  Created by Marco Boschi on 05/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

@IBDesignable class VariableToolbar: UIToolbar {
	
	@IBInspectable var customHeight: CGFloat = 44
	
	override func layoutSubviews() {
		super.layoutSubviews()
		frame.size.height = customHeight
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		var size = super.sizeThatFits(size)
		size.height = customHeight
		
		return size
	}
	
}
