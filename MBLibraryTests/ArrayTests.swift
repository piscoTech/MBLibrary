//
//  ArrayTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class ArrayTests: XCTestCase {
	
	var a, b, c, d: [Int]!

    override func setUp() {
        super.setUp()
		
		a = [4,2,-6]
		b = [9,0,10]
		c = [1,2,3,5]
		d = [2,2,1,1,3,4]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testAppendUnique() {
		XCTAssertFalse(a.appendUnique(4))
		XCTAssertTrue(a.appendUnique(3))
		XCTAssertFalse(a.appendUnique(3))
	}
	
	func testRemove() {
		XCTAssertEqual(1, a.removeElement(4))
		XCTAssertEqual(a, [2,-6])
		
		var d = [1,2,1,3,1]
		XCTAssertEqual(3, d.removeElement(1))
		XCTAssertEqual(d, [2,3])
	}
	
	func testRemoveDuplicate() {
		a.removeDuplicates()
		d.removeDuplicates()
		
		XCTAssertEqual(a, [4,2,-6])
		XCTAssertEqual(d, [2,1,3,4])
	}
	
	func testUnion() {
		var res = d.union(c)
		XCTAssertEqual(res, [2,1,3,4,5])
		
		res = c.union(d)
		XCTAssertEqual(res, [1,2,3,5,4])
	}
	
	func testIntersect() {
		var res = d.intersect(c)
		XCTAssertEqual(res, [2,1,3])
		
		res = c.intersect(d)
		XCTAssertEqual(res, [1,2,3])
	}
	
	func testSubtract() {
		var res = d.subtract(c)
		XCTAssertEqual(res, [4])
		
		res = c.subtract(d)
		XCTAssertEqual(res, [5])
	}

}
