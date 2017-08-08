//
//  FadedLayer.swift
//  MBLibrary
//
//  Created by Marco Boschi on 08/08/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import QuartzCore

///A layer of a white rectangle with faded sides intented to be used as a mask for other layers.
public class FadedLayer: CALayer {
	
	///The size in point of the fade. Setting this property to a non-nil or non-negative value overrides `fadePercentage`.
	public var fadeSize: CGFloat? {
		didSet {
			if let val = fadeSize {
				if val >= 0 {
					fadePercentage = nil
				} else {
					fadeSize = nil
				}
			}
		}
	}
	
	///The size in percentage of the fade, if the dimensions are not equals, i.e. not a square, the percentage is calculed on the shortest side. Setting this property to a non-nil or non-negative value overrides `fadeSize`.
	public var fadePercentage: CGFloat? {
		didSet {
			if let val = fadePercentage {
				if val >= 0 {
					fadeSize = nil
				} else {
					fadePercentage = nil
				}
			}
		}
	}

	override public convenience init(layer: Any) {
		self.init()
		
		if let fade = layer as? FadedLayer {
			self.fadeSize = fade.fadeSize
			self.fadePercentage = fade.fadePercentage
		}
	}
	
	override public init() {
		super.init()
		
		backgroundColor = nil
		setNeedsDisplay()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func draw(in ctx: CGContext) {
		let white = CGColor.createWithComponents(gray: 1)
		let clear = CGColor.createWithComponents(gray: 1, alpha: 0)
		ctx.setFillColor(white)
		
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceGray(), colors: [white, clear] as CFArray, locations: [0, 1]) else {
			fatalError("Something went horribly wrong for not beeing able to create the gradient")
		}
		let fadeSize = self.fadeSize ?? (min(bounds.width, bounds.height) * (self.fadePercentage ?? 0))
		
		// Middle part full opaque
		let middle = CGRect(x: fadeSize, y: fadeSize,
		                    width: bounds.width - 2*fadeSize, height: bounds.height - 2*fadeSize)
		ctx.fill(middle)
		
		// Top
		ctx.saveGState()
		let top = CGRect(x: fadeSize, y: 0, width: middle.size.width, height: fadeSize)
		ctx.addRect(top)
		ctx.clip()
		ctx.drawLinearGradient(gradient, start: CGPoint(x: fadeSize, y: fadeSize), end: CGPoint(x: fadeSize, y: 0), options: [])
		ctx.restoreGState()
		
		// Bottom
		ctx.saveGState()
		let bottom = CGRect(origin: CGPoint(x: fadeSize, y: fadeSize + middle.size.height),
		                    size: top.size)
		ctx.addRect(bottom)
		ctx.clip()
		ctx.drawLinearGradient(gradient, start: bottom.origin, end: CGPoint(x: fadeSize, y: bounds.height), options: [])
		ctx.restoreGState()
		
		// Left
		ctx.saveGState()
		let left = CGRect(x: 0, y: fadeSize, width: fadeSize, height: middle.size.height)
		ctx.addRect(left)
		ctx.clip()
		ctx.drawLinearGradient(gradient, start: CGPoint(x: fadeSize, y: fadeSize), end: CGPoint(x: 0, y: fadeSize), options: [])
		ctx.restoreGState()
		
		// Right
		ctx.saveGState()
		let right = CGRect(origin: CGPoint(x: fadeSize + middle.size.width, y: fadeSize),
		                   size: left.size)
		ctx.addRect(right)
		ctx.clip()
		ctx.drawLinearGradient(gradient, start: right.origin, end: CGPoint(x: bounds.width, y: fadeSize), options: [])
		ctx.restoreGState()
		
		var center: CGPoint
		
		// Top Left
		ctx.saveGState()
		let topLeft = CGRect(origin: .zero, size: CGSize(width: fadeSize, height: fadeSize))
		ctx.addRect(topLeft)
		ctx.clip()
		center = CGPoint(x: fadeSize, y: fadeSize)
		ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: fadeSize, options: .drawsAfterEndLocation)
		ctx.restoreGState()
		
		// Top Right
		ctx.saveGState()
		let topRight = CGRect(origin: CGPoint(x: fadeSize + middle.size.width, y: 0), size: topLeft.size)
		ctx.addRect(topRight)
		ctx.clip()
		center = CGPoint(x: fadeSize + middle.size.width, y: fadeSize)
		ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: fadeSize, options: .drawsAfterEndLocation)
		ctx.restoreGState()
		
		// Bottom Left
		ctx.saveGState()
		let bottomLeft = CGRect(origin: CGPoint(x: 0, y: fadeSize + middle.size.height), size: topLeft.size)
		ctx.addRect(bottomLeft)
		ctx.clip()
		center = CGPoint(x: fadeSize, y: fadeSize + middle.size.height)
		ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: fadeSize, options: .drawsAfterEndLocation)
		ctx.restoreGState()
		
		// Bottom Right
		ctx.saveGState()
		let bottomRight = CGRect(origin: CGPoint(x: fadeSize + middle.size.width, y: fadeSize + middle.size.height), size: topLeft.size)
		ctx.addRect(bottomRight)
		ctx.clip()
		center = bottomRight.origin
		ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: fadeSize, options: .drawsAfterEndLocation)
		ctx.restoreGState()
	}
	
}
