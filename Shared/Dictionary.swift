//
//  Dictionary.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

///Add all the pairs of the second dictionary to the first one, if a key already exists its value is replaced.
public func + <K,V>(left: [K: V], right: [K: V]) -> [K: V] {
	var res = left
	res += right
	return res
}

///Add all the pairs of the second dictionary to the first one, if a key already exists its value is replaced.
public func += <K,V>(left: inout [K: V], right: [K: V]) {
	for (k, v) in right {
		left[k] = v
	}
}
