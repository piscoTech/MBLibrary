//
//  DateTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {
	
	var d: Date!

    override func setUp() {
        super.setUp()
		
		// Jul 19, 2016, 9:42 PM
		d = Date(timeIntervalSince1970: 1468957321)
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUNIX() {
        XCTAssertEqual(d.getUNIXDateTime(), "2016-07-19 21:42")
    }

}
