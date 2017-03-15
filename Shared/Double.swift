//
//  Double.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Double {
	
	public func toCSV() -> String {
		var n = "\(self)"
		
		if let point = n.range(of: ".") {
			n = n.replacingCharacters(in: point, with: decimalPoint)
		}
		
		return n.toCSV()
	}
	
	public func toString() -> String {
		var num = self
		let negative = num < 0
		if negative { num *= -1 }
		var base = "\(num)".replacingOccurrences(of: ".", with: decimalPoint)
		
		if base.range(of: "e") != nil {
			let parts = base.components(separatedBy: "e")
			base = parts[0]
			let n = Int(parts[1])!
			
			if n < 0 {
				let zeros = ([String](repeating: "0", count: -n-1)).joined(separator: "")
				base = "0" + decimalPoint + zeros
					+ base.replacingOccurrences(of: decimalPoint, with: "")
			} else if n > 0 {
				var numSeparated = base.components(separatedBy: decimalPoint)
				if numSeparated.count == 1 { numSeparated[1] = "" }
				let nDec=numSeparated[1].characters.count
				if n > nDec {
					numSeparated[1] += ([String](repeating: "0", count: n-nDec)).joined(separator: "")
				}
				
				base=numSeparated[0] + numSeparated[1][0..<n] + decimalPoint
				
				if n < nDec {
					base += numSeparated[1][n..<nDec]
				}
				
				if base[base.characters.count-1] == decimalPoint {
					base = base[0..<(base.characters.count-1)]
				}
			}
		}
		
		//Delete negative part if equal to zero
		var numParts = base.components(separatedBy: decimalPoint)
		if numParts.count == 2 && (
			fmod(num, 1) == 0
				|| numParts[1] == ([String](repeating: "0", count: numParts[1].characters.count)).joined(separator: "")
			) {
			base = numParts[0]
		}
		
		if negative { base = "-" + base }
		if base == "-0" { base = "0" }
		
		return base
	}
	
	public func rounded(to: Double) -> Double {
		return (self / to).rounded() * to
	}
	
	mutating public func round(to: Double) {
		self = self.rounded(to: to)
	}
	
	// MARK: - RNG
	
	///Generate a random number between `from` (inclusive) and `to` (exclusive).
	public static func random(from: Double, to: Double) -> Double {
		seedRng()
		
		var a = from
		var b = to
		if a > b {
			let tmp = a
			a = b
			b = tmp
		}
		
		return drand48() * (b - a) + a
	}
	
	///Generate a random number between `0` (inclusive) and `to` (exclusive).
	public static func random(to: Double = 1) -> Double {
		return random(from: 0, to: to)
	}
	
	///Seed the random number generator with the specified seed, if none the current time will be used. This also seed the `Int` and `Bool` number generator.
	public static func seedRandom(_ s: Int? = nil) {
		seedRng(s, forceSeed: true)
	}
	
}
