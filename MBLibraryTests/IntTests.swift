//
//  IntTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 13/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRange() {
		let min = 10
		let max = 103
		for _ in 0 ..< 1000 {
			let i = Int.random(from: min, to: max)
			if i < min || i >= max {
				XCTFail("Generated number outside range")
			}
		}
    }
    
}
