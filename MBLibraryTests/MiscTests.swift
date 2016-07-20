//
//  MiscTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest
import CoreGraphics

class MiscTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testMaxMin() {
		XCTAssertNil(max([Int]()))
		XCTAssertNil(min([Int]()))
		
		let a = [2,8,9,-1,0,-7]
		XCTAssertEqual(max(a), 9)
		XCTAssertEqual(min(a), -7)
	}
	
	func testSign() {
		XCTAssertTrue(sgn(1) > 0)
		XCTAssertTrue(sgn(-1) < 0)
		XCTAssertTrue(sgn(0) == 0)
		XCTAssertTrue(sgn(1.0) > 0)
		XCTAssertTrue(sgn(-2.5) < 0)
		XCTAssertTrue(sgn(0.0) == 0)
	}
	
	func testSumPoint() {
		let a = CGPoint(x: 3, y: 7)
		let b = CGPoint(x: 1, y: -3)
		let sum = a + b
		XCTAssertEqual(CGPoint(x: 4, y: 4), sum)
	}

}
