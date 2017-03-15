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
		
		a = TimeInterval(2 * 3600 + 34 * 60 + 15) // 2h 34m 15s
		b = 20 // 20s
		c = TimeInterval(2 * 3600 + 4 * 60 + 5) // 2h 4m 5s
		d = TimeInterval(1 * 60 + 25) // 1m 25s
		e = TimeInterval(10 * 60 + 25) // 10m 25s
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testDuration() {
		XCTAssertEqual(a.getDuration(), "2:34:15")
		XCTAssertEqual(a.getDuration(hideHours: true), "2:34:15")
		XCTAssertEqual(b.getDuration(), "0:00:20")
		XCTAssertEqual(b.getDuration(hideHours: true), "0:20")
		XCTAssertEqual(c.getDuration(), "2:04:05")
		XCTAssertEqual(c.getDuration(hideHours: true), "2:04:05")
		XCTAssertEqual(d.getDuration(), "0:01:25")
		XCTAssertEqual(d.getDuration(hideHours: true), "1:25")
		XCTAssertEqual(e.getDuration(), "0:10:25")
		XCTAssertEqual(e.getDuration(hideHours: true), "10:25")
	}

}
