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
	
	func testClamp() {
		XCTAssertEqual(1, clamp(0, 1, 3))
		XCTAssertEqual(2, clamp(2, 1, 3))
		XCTAssertEqual(3, clamp(5, 1, 3))
		XCTAssertEqual(1, clamp(1, 1, 3))
		XCTAssertEqual(3, clamp(3, 1, 3))
		
		XCTAssertEqual(1.5, clamp(0, 1.5, 3))
		XCTAssertEqual(2.1, clamp(2.1, 1.5, 3))
		XCTAssertEqual(3, clamp(3.1, 1.5, 3))
		XCTAssertEqual(3, clamp(3, 1.5, 3))
	}

}
