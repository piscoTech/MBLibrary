//
//  Complex.swift
//  Matrix
//
//  Created by Marco Boschi on 01/05/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

public func == (l: Complex, r: Complex) -> Bool {
	return l.r == r.r && l.i == r.i
}

public func + (l: Complex, r: Complex) -> Complex {
	return Complex(re: l.r + r.r, im: l.i + r.i)
}

public func * (l: Complex, r: Complex) -> Complex {
	return Complex(re: l.r * r.r - l.i * r.i, im: l.r * r.i + l.i * r.r)
}

public func * (l: Complex, r: Double) -> Complex {
	return Complex(re: l.r * r, im: l.i * r)
}

public func * (l: Double, r: Complex) -> Complex {
	return r * l
}

public func / (l: Complex, r: Complex) -> Complex {
	let denom = r.r * r.r + r.i * r.i
	return Complex(re: (l.r * r.r + l.i * r.i)/denom, im: (l.i * r.r - l.r * r.i)/denom)
}

public struct Complex: Equatable, CustomStringConvertible {
	
	public var r, i: Double
	public var description: String {
		get {
			var re = r.toString()
			var im = i.toString()
			if(r >= 0) { re = "+" + re }
			if(i >= 0) { im = "+" + im }
			
			return "\(re)\(im)𝒊"
		}
	}
	
	public init(re: Double, im: Double) {
		r = re
		i = im
	}
	
	public var isReal: Bool {
		return i == 0
	}
	
	public var isComplex: Bool {
		return i != 0
	}
	
	public func conjugate() -> Complex {
		return Complex(re: r, im: -i)
	}
	
	public func abs() -> Double {
		return sqrt(r*r + i*i)
	}
	
	public static let zero = Complex(re: 0, im: 0)
	
}
