//
//  Misc.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

public func max<T: Comparable>(_ num: [T]) -> T? {
	var res = num.first
	for n in num {
		res = max(res!, n)
	}
	
	return res
}

public func min<T: Comparable>(_ num: [T]) -> T? {
	var res = num.first
	for n in num {
		res = min(res!, n)
	}
	
	return res
}

public func clamp<T: Comparable>(_ num: T, _ minVal: T, _ maxVal: T) -> T {
	guard minVal <= maxVal else {
		preconditionFailure("minVal cannot be greater than maxVal")
	}
	
	return min(max(minVal, num), maxVal)
}

public func sgn<T: SignedNumber>(_ x: T) -> Int {
	let absX = abs(x)
	if x == absX && x != -x {
		return 1
	} else if x == -absX && x != absX {
		return -1
	} else {
		return 0
	}
}
