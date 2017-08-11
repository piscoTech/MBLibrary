//
//  NSFont.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Cocoa

extension NSFont {
	
	public func makeMonospacedDigit() -> NSFont {
		let size = self.pointSize
		let desc = self.fontDescriptor
		
		let monospaced = desc.addingAttributes([
			.featureSettings: [
				[
					NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
					.selectorIdentifier: kMonospacedNumbersSelector
				]
			]
			])
		
		return NSFont(descriptor: monospaced, size: size)!
	}
	
}
