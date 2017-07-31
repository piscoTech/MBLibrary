//
//  CGPoint.swift
//  MBLibrary
//
//  Created by Marco Boschi on 17/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import CoreGraphics

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public prefix func - (p: CGPoint) -> CGPoint {
	return CGPoint(x: -p.x, y: -p.y)
}

extension CGPoint {
	
	public var module: CGFloat {
		return sqrt(x*x + y*y)
	}
	
	public func normalized() -> CGPoint {
		let m = module
		guard m != 0 else {
			return .zero
		}
		
		return CGPoint(x: x / m, y: y / m)
	}
	
	///The angle (in radians) described by the vector relative to the positive x axis in `(-π, π]` range.
	public var angle: CGFloat {
		if x == 0 {
			return .pi / 2 * sgn(y)
		}
		
		let res = atan(y / x) + (x < 0 ? .pi : 0)
		switch res {
		case let tmp where tmp > .pi:
			return tmp - 2 * .pi
		case let tmp where tmp < -.pi:
			return tmp + 2 * .pi
		case let tmp:
			return tmp
		}
		
	}
	
	public func scale(by f: CGFloat) -> CGPoint {
		return CGPoint(x: x*f, y: y*f)
	}
	
}
