//
//  Numbers.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 11/08/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

extension Comparable {
	
	/// Temporary placeholder waiting for direct implementation in Swift.
	public func clamped(to range: ClosedRange<Self>) -> Self {
		if self > range.upperBound {
			return range.upperBound
		} else if self < range.lowerBound {
			return range.lowerBound
		} else {
			return self
		}
	}
	
}

public func sgn<T: SignedNumeric & Comparable>(_ x: T) -> T {
	let absX = abs(x)
	if x == absX && x != -x {
		return 1
	} else if x == -absX && x != absX {
		return -1
	} else {
		return 0
	}
}
