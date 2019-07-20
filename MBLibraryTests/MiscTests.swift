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
	
	func testSign() {
		XCTAssertTrue(sgn(1) > 0)
		XCTAssertTrue(sgn(-1) < 0)
		XCTAssertEqual(sgn(0), 0)
		
		XCTAssertTrue(sgn(1.0) > 0)
		let neg = -2.5
		XCTAssertTrue(sgn(neg) < 0)
		XCTAssertEqual(sgn(0.0), 0)
		
		var f: Float = 1
		XCTAssertTrue(sgn(f) > 0)
		f = -2.5
		XCTAssertTrue(sgn(f) < 0)
		f = 0
		XCTAssertEqual(sgn(f), 0)
		
		var cgf: CGFloat = 1
		XCTAssertTrue(sgn(cgf) > 0)
		cgf = -2.5
		XCTAssertTrue(sgn(cgf) < 0)
		cgf = 0
		XCTAssertEqual(sgn(cgf), 0)
	}
	
	func testClamp() {
		XCTAssertEqual(1, 0.clamped(to: 1 ... 3))
		XCTAssertEqual(2, 2.clamped(to: 1 ... 3))
		XCTAssertEqual(3, 5.clamped(to: 1 ... 3))
		XCTAssertEqual(1, 1.clamped(to: 1 ... 3))
		XCTAssertEqual(3, 3.clamped(to: 1 ... 3))
		
		XCTAssertEqual(1.5, 0.clamped(to: 1.5 ... 3))
		XCTAssertEqual(2.1, (2.1).clamped(to: 1.5 ... 3))
		XCTAssertEqual(3, (3.1).clamped(to: 1.5 ... 3))
		XCTAssertEqual(3, 3.clamped(to: 1.5 ... 3))
	}

}
