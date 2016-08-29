//
//  UIFont.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

extension UIFont {
	
	public func makeMonospacedDigit() -> UIFont {
		let size = self.pointSize
		let desc = self.fontDescriptor
		let monospaced = desc.addingAttributes([
			UIFontDescriptorFeatureSettingsAttribute: [
				[
					UIFontFeatureTypeIdentifierKey: kNumberSpacingType,
					UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
				]
			]
			])
		
		return UIFont(descriptor: monospaced, size: size)
	}
	
}
