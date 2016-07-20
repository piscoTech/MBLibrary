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

}
