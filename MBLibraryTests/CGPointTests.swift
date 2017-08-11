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
		XCTAssertEqual(2 * sqrt(2), c.module, accuracy: 0.0001)
	}
	
	func testNormalization() {
		let val: CGFloat = sqrt(2) / 2
		let norm = c.normalized()
		XCTAssertEqual(val, norm.x, accuracy: 0.0001)
		XCTAssertEqual(val, norm.y, accuracy: 0.0001)
	}
	
	func testAngle() {
		XCTAssertEqual(.pi / 2, CGPoint(x: 0, y: 1).angle, accuracy: 0.0001)
		XCTAssertEqual(-.pi / 2, CGPoint(x: 0, y: -1).angle, accuracy: 0.0001)
		
		let sr = sqrt(3)/2
		XCTAssertEqual(.pi / 3, CGPoint(x: 0.5, y: sr).angle, accuracy: 0.0001)
		XCTAssertEqual(2 * .pi / 3, CGPoint(x: -0.5, y: sr).angle, accuracy: 0.0001)
		XCTAssertEqual(-.pi / 3, CGPoint(x: 0.5, y: -sr).angle, accuracy: 0.0001)
		XCTAssertEqual(-2 * .pi / 3, CGPoint(x: -0.5, y: -sr).angle, accuracy: 0.0001)
		
		XCTAssertEqual(.pi / 6, CGPoint(x: sr, y: 0.5).angle, accuracy: 0.0001)
		XCTAssertEqual(5 * .pi / 6, CGPoint(x: -sr, y: 0.5).angle, accuracy: 0.0001)
		XCTAssertEqual(-.pi / 6, CGPoint(x: sr, y: -0.5).angle, accuracy: 0.0001)
		XCTAssertEqual(-5 * .pi / 6, CGPoint(x: -sr, y: -0.5).angle, accuracy: 0.0001)
	}
	
}
