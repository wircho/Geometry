//
//  GeometrySampleTests.swift
//  GeometrySampleTests
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import XCTest
@testable import Result
@testable import GeometrySample

class GeometrySampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFreeScalar() {
        // Create free scalar
        let position: CGFloat = 856.24
        let freeScalar = FreeScalar(at: position)
        guard let value = freeScalar.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position == value)
        // Move free scalar
        let position1: CGFloat = 83456.1524
        freeScalar.position = position1
        guard let value1 = freeScalar.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position1 == value1)
    }
    
    func testFreePoint() {
        // Create free point
        let position = CGPoint(x: 0.25, y: 3.481)
        let freePoint = FreePoint(at: position)
        guard let value = freePoint.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position == value)
        // Move free point
        let position1 = CGPoint(x: 20.31, y: 18.456)
        freePoint.position = position1
        guard let value1 = freePoint.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position1 == value1)
    }
    
    func testLine2Points() {
        // Create line
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
