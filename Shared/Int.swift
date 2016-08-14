//
//  Int.swift
//  MBLibrary
//
//  Created by Marco Boschi on 13/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

private var seeded = false

extension Int {
	
	///Generate a random number between `from` (inclusive) and `to` (exclusive).
	public static func random(from: Int, to: Int) -> Int {
		if !seeded {
			srand48(Int(Date().timeIntervalSince1970))
			seeded = true
		}
		
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
	
}
