//
//  CGPointTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class CGPointTests: XCTestCase {
	
	let a = CGPoint(x: 3, y: 7)
	let b = CGPoint(x: 1, y: -3)
	let c = CGPoint(x: 2, y: 2)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testSum() {
		let sum = a + b
		XCTAssertEqual(CGPoint(x: 4, y: 4), sum)
	}
	
	func testDifference() {
		let difference = b - a
		XCTAssertEqual(CGPoint(x: -2, y: -10), difference)
	}
	
	func testInverse() {
		XCTAssertEqual(CGPoint(x: -1, y: 3), -b)
	}
	
	func testModule() {
		XCTAssertEqualWithAccuracy(2 * sqrt(2), c.module, accuracy: 0.0001)
	}
	
	func testNormalization() {
		let val: CGFloat = sqrt(2) / 2
		let norm = c.normalized()
		XCTAssertEqualWithAccuracy(val, norm.x, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(val, norm.y, accuracy: 0.0001)
	}
	
}
