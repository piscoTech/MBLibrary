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
			.featureSettings: [
				[
					UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
					.typeIdentifier: kMonospacedNumbersSelector
				]
			]
			])
		
		return UIFont(descriptor: monospaced, size: size)
	}
	
}
