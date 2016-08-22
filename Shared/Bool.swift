//
//  Bool.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Bool {

	///Generate a random boolean.
	public static func random() -> Bool {
		seedRng()
		
		return drand48() < 0.5
	}

	///Seed the random number generator with the specified seed, if none the current time will be used. This also seed the `Double` and `Int` number generator.
	public static func seedRandom(_ s: Int? = nil) {
		seedRng(s, forceSeed: true)
	}

}
