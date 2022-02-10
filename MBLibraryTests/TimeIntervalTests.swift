//
//  TimeIntervalTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class TimeIntervalTests: XCTestCase {
	
	var a, c, b, d, e: TimeInterval!

    override func setUp() {
        super.setUp()
		
		a = 2 * 3600 + 34 * 60 + 15 // 2h 34m 15s
		b = 20 // 20s
		c = 2 * 3600 + 4 * 60 + 5 // 2h 4m 5s
		d = 1 * 60 + 25 // 1m 25s
		e = 10 * 60 + 25 // 10m 25s
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testDuration() {
		XCTAssertEqual(a.rawDuration(), "2:34:15")
		XCTAssertEqual(b.rawDuration(), "0:00:20")
		XCTAssertEqual(c.rawDuration(), "2:04:05")
		XCTAssertEqual(d.rawDuration(), "0:01:25")
		XCTAssertEqual(e.rawDuration(), "0:10:25")
		
		XCTAssertEqual(a.rawDuration(hidingHours: true), "2:34:15")
		XCTAssertEqual(b.rawDuration(hidingHours: true), "0:20")
		XCTAssertEqual(c.rawDuration(hidingHours: true), "2:04:05")
		XCTAssertEqual(d.rawDuration(hidingHours: true), "1:25")
		XCTAssertEqual(e.rawDuration(hidingHours: true), "10:25")
	}

}
