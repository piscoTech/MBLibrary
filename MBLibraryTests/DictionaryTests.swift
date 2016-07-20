//
//  DictionaryTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class DictionaryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSum() {
		let a = [1: "Lol", 3: "Ok"]
		let b = [2: "Lmao", 3: "Hi"]
		let sum = a + b
		
		XCTAssertEqual(sum[1], a[1])
		XCTAssertEqual(sum[2], b[2])
		XCTAssertNotEqual(sum[3], a[3])
		XCTAssertEqual(sum[3], b[3])
    }

}
