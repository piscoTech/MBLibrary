//
//  Support Types.swift
//  MBLibrary
//
//  Created by Marco Boschi on 15/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

public func == (l: Float3, r: Float3) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
}

public func + (l: Float3, r: Float3) -> Float3 {
	return [l.x + r.x, l.y + r.y, l.z + r.z]
}

public func - (l: Float3, r: Float3) -> Float3 {
	return [l.x - r.x, l.y - r.y, l.z - r.z]
}

prefix operator - {}
public prefix func - (p: Float3) -> Float3 {
	return [-p.x, -p.y, -p.z]
}

public struct Float3: ArrayLiteralConvertible, Equatable {
	
	public typealias Element = Float
	public let x, y, z: Float
	
	public init(arrayLiteral elements: Element...) {
		self.x = elements[0]
		self.y = elements[1]
		self.z = elements[2]
	}
	
	public func crossProduct(_ b: Float3) -> Float3 {
		let a = self
		return [a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x]
	}
	
	public func module() -> Float {
		return sqrt(x*x + y*y + z*z)
	}
	
	public func normalized() -> Float3 {
		let module = self.module()
		guard module != 0 else {
			return [0,0,0]
		}
		
		return [x / module, y / module, z / module]
	}
	
}

public struct Face: ArrayLiteralConvertible {
	
	public typealias Element = Float3
	public let a, b, c: Float3
	public let normal: Float3
	
	///Create a triangular face by specifying the three vertices in counter-clockwise order, normal will be automatically calculated.
	public init(arrayLiteral v: Element...) {
		self.init(arrayLiteral: v)
	}
	
	///Create a triangular face by specifying the three vertices in counter-clockwise order, normal will be automatically calculated.
	public init(arrayLiteral vertices: [Element]) {
		self.a = vertices[0]
		self.b = vertices[1]
		self.c = vertices[2]
		
		let v = b - a
		let w = c - a
		let crossProduct = v.crossProduct(w)
		normal = crossProduct.normalized()
	}
	
	public var rawData: [Float3] {
		return [a, normal, b, normal, c, normal]
	}
	
}
