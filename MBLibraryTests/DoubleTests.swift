//
//  DoubleTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class DoubleTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testToString() {
		XCTAssertEqual((40.0).toString(), "40")
		XCTAssertEqual((-40.7).toString(), "-40\(decimalPoint)7")
		XCTAssertEqual((0).toString(), "0")
		XCTAssertEqual((1e12 + 0.16).toString(), "1000000000000\(decimalPoint)16")
		XCTAssertEqual((-1e12 - 0.16).toString(), "-1000000000000\(decimalPoint)16")
	}
	
	func testRoundTo() {
		XCTAssertEqual(1, (1.2).rounded(to: 0.5))
		XCTAssertEqual(-1, (-1.2).rounded(to: 0.5))
		XCTAssertEqual(1.5, (1.3).rounded(to: 0.5))
		XCTAssertEqual(-1.5, (-1.3).rounded(to: 0.5))
		XCTAssertEqual(1.5, (1.7).rounded(to: 0.5))
		XCTAssertEqual(-1.5, (-1.7).rounded(to: 0.5))
		
		var d = 1.2
		d.round(to: 0.5)
		XCTAssertEqual(1, d)
		d = -1.2
		d.round(to: 0.5)
		XCTAssertEqual(-1, d)
		d = 1.3
		d.round(to: 0.5)
		XCTAssertEqual(1.5, d)
		d = -1.3
		d.round(to: 0.5)
		XCTAssertEqual(-1.5, d)
		d = 1.7
		d.round(to: 0.5)
		XCTAssertEqual(1.5, d)
		d = -1.7
		d.round(to: 0.5)
		XCTAssertEqual(-1.5, d)
	}
	
	func testRange() {
		let min = 10.0
		let max = 103.0
		for _ in 0 ..< 1000 {
			let i = Double.random(from: min, to: max)
			if i < min || i >= max {
				XCTFail("Generated number outside range")
			}
		}
		
		for _ in 0 ..< 1000 {
			let i = Double.random()
			if i < 0 || i >= 1 {
				XCTFail("Generated number outside range")
			}
		}
	}

}
