//
//  EnhancedNavigationBar.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 01/08/2018.
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import UIKit

public protocol EnhancedNavigationBarDelegate: AnyObject {
	
	func largeTitleChanged(isLarge: Bool)
	
}

public class EnhancedNavigationBar: UINavigationBar {
	
	@IBInspectable public var defaultHeight: CGFloat = 44
	public weak var enhancedDelegate: EnhancedNavigationBarDelegate?

	override public func layoutSubviews() {
		super.layoutSubviews()
		
		if #available(iOS 11, *) {
			enhancedDelegate?.largeTitleChanged(isLarge: frame.height > defaultHeight)
		}
	}

}
