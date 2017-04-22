//
//  MainTests.swift
//  Matrix
//
//  Created by Marco Boschi on 04/04/15.
//  Copyright (c) 2015 Marco Boschi. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testLength() {
		XCTAssertEqual("Hello".length, 5)
		XCTAssertEqual("😂🔝".length, 2)
	}
	
	func testDigit() {
		XCTAssertTrue("985743".isDigit())
		XCTAssertFalse("Hello, world!".isDigit())
		XCTAssertFalse("12345f".isDigit())
		XCTAssertFalse("".isDigit())
	}

    func testToDouble() {
		let notDecimalPoint = decimalPoint == "." ? "," : "."
		
		var s="0\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="-0\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(-0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="+0\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="+\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="-\(decimalPoint)5"
		XCTAssertEqualWithAccuracy(-0.5, s.toDouble()!, accuracy: 0.000001)
		
		s="3"
		XCTAssertEqualWithAccuracy(3, s.toDouble()!, accuracy: 0.000001)
		
		s="-3"
		XCTAssertEqualWithAccuracy(-3, s.toDouble()!, accuracy: 0.000001)
		
		s="3\(notDecimalPoint)3"
		XCTAssertNil(s.toDouble())
    }
	
	func testSubstring() {
		XCTAssertEqual("d!", ("Hello World!").substring(from: -2))
		XCTAssertEqual("!", ("Hello World!").substring(from: -1))
		
		XCTAssertEqual("H", ("Hello World!").substring(to: 1))
		XCTAssertEqual("He", ("Hello World!").substring(to: 2))
		
		XCTAssertEqual("llo World!", ("Hello World!").substring(from: 2))
		XCTAssertEqual("Hello Worl", ("Hello World!").substring(to: -2))
		
		XCTAssertEqual("ll", ("Hello World!").substring(with: 2..<4))
		XCTAssertEqual("ll", ("Hello World!")[2..<4])
	}

}
