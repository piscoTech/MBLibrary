//
//  TimeIntervalTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class TimeIntervalTests: XCTestCase {
	
	var a, c, b: TimeInterval!

    override func setUp() {
        super.setUp()
		
		a = 2*3600 + 34*60 + 15 // 2h 34m 15s
		b = 20 // 20s
		c = 2*3600 + 4*60 + 5 // 2h 4m 5s
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testDuration() {
		XCTAssertEqual(a.getDuration(), "2:34:15")
		XCTAssertEqual(b.getDuration(), "0:00:20")
		XCTAssertEqual(c.getDuration(), "2:04:05")
	}

}
