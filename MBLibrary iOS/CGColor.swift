//
//  CGColor.swift
//  MBLibrary
//
//  Created by Marco Boschi on 07/08/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import QuartzCore

extension CGColor {
	
	public static func createWithComponents(gray: CGFloat, alpha: CGFloat = 1) -> CGColor {
		guard let res = CGColor(colorSpace: CGColorSpaceCreateDeviceGray(), components: [gray, alpha]) else {
			fatalError("Something went hoorible wrong for not beeing able to create the color")
		}
		
		return res
	}
	
	public static func createWithComponents(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> CGColor {
		guard let res = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [red, green, blue, alpha]) else {
			fatalError("Something went hoorible wrong for not beeing able to create the color")
		}
		
		return res
	}
	
}
