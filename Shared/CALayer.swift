//
//  CALayer.swift
//  MBLibrary
//
//  Created by Marco Boschi on 08/08/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import QuartzCore

extension CALayer {
	
	public func applyScreenScale(_ scale: CGFloat) {
		self.shouldRasterize = true
		self.contentsScale = scale
		self.rasterizationScale = scale
		
		for l in self.sublayers ?? [] {
			l.applyScreenScale(scale)
		}
		self.mask?.applyScreenScale(scale)
		
		self.setNeedsDisplay()
	}
	
}
