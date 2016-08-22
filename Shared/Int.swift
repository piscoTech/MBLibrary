//
//  Int.swift
//  MBLibrary
//
//  Created by Marco Boschi on 13/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Int {
	
	///Generate a random number between `from` (inclusive) and `to` (exclusive).
	public static func random(from: Int, to: Int) -> Int {
		seedRng()
		
		var a = from
		var b = to
		if a > b {
			let tmp = a
			a = b
			b = tmp
		}
		
		return Int(drand48() * Double(b - a)) + a
	}
	
	///Generate a random number between `0` (inclusive) and `to` (exclusive).
	public static func random(to: Int) -> Int {
		return random(from: 0, to: to)
	}
	
	///Seed the random number generator with the specified seed, if none the current time will be used. This also seed the `Double` and `Bool` number generator.
	public static func seedRandom(_ s: Int? = nil) {
		seedRng(s, forceSeed: true)
	}
	
}
