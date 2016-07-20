//
//  ArrayTests.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

extension Int: Sortable {
	
	public func sortBefore(_ oth: Int) -> Bool {
		return self < oth
	}
	
}

class ArrayTests: XCTestCase {
	
	var a, b, c: [Int]!

    override func setUp() {
        super.setUp()
		
		a = [4,2,-6]
		b = [9,0,10]
		c = [1,2,3]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSort() {
        let aSort = a.sorted()
		a.sort()
		XCTAssertEqual(aSort, a)
		
		XCTAssertEqual(c, c.sorted())
		XCTAssertEqual(b.sorted(), [0,9,10])
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

}
