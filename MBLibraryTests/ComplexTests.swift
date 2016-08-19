//
//  ComplexTests.swift
//  Matrix
//
//  Created by Marco Boschi on 02/05/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import XCTest

class ComplexTests: XCTestCase {
	
	var a, b, c, d: Complex!
	
    override func setUp() {
        super.setUp()
		
		a = Complex(re: 2, im: -2)
		b = Complex(re: -2, im: 0)
		c = Complex(re: 0, im: 3)
		d = Complex(re: 2, im: 4)
    }
	
	func testType() {
		XCTAssert(a.isComplex())
		XCTAssert(!a.isReal())
		XCTAssert(b.isReal())
		XCTAssert(!b.isComplex())
		XCTAssert(c.isComplex())
		XCTAssert(!c.isReal())
	}
    
    func testSum() {
        var sum = a + b
		XCTAssertEqualWithAccuracy(sum.r, 0, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(sum.i, -2, accuracy: 0.0001)
		
		sum = b + c
		XCTAssertEqualWithAccuracy(sum.r, -2, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(sum.i, 3, accuracy: 0.0001)
    }
	
	func testEquality() {
		XCTAssertEqual(b + c, Complex(re: -2, im: 3))
	}
	
	func testProduct() {
		var prod = b * c
		XCTAssertEqualWithAccuracy(prod.r, 0, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(prod.i, -6, accuracy: 0.0001)
		
		prod = a * d
		XCTAssertEqualWithAccuracy(prod.r, 12, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(prod.i, 4, accuracy: 0.0001)
		
		prod = 3.1 * a
		XCTAssertEqualWithAccuracy(prod.r, 6.2, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(prod.i, -6.2, accuracy: 0.0001)
		XCTAssertEqual(prod, a * 3.1)
	}
	
	func testDivision() {
		let div = a / d
		XCTAssertEqualWithAccuracy(div.r, -0.2, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(div.i, -0.6, accuracy: 0.0001)
	}
	
	func testConjugate() {
		let conj = a.conjucate()
		XCTAssertEqualWithAccuracy(conj.r, a.r, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(conj.i, -a.i, accuracy: 0.0001)
		
		XCTAssertEqual(b, b.conjucate())
	}
	
	func testModule() {
		XCTAssertEqualWithAccuracy(a.abs(), 2.8284, accuracy: 0.0001)
		XCTAssertEqualWithAccuracy(b.abs(), abs(b.r), accuracy: 0.0001)
	}
    
}
