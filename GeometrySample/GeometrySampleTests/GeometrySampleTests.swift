//
//  GeometrySampleTests.swift
//  GeometrySampleTests
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import XCTest
import CoreGraphics
import Result
@testable import GeometrySample

class FailPoint: Point {
    private var failure: MathError
    
    init(_ failure: MathError) {
        self.failure = failure
        super.init()
    }
    
    override func recalculate() -> Result<CGPoint, MathError> {
        return .failure(failure)
    }
}

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
        // Constants
        let position0: GeometrySample.Float = 856.24
        let position1: GeometrySample.Float = 83456.1524
        // Create free scalar
        let freeScalar = FreeScalar(at: position0)
        guard let value0 = freeScalar.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position0 == value0)
        // Move free scalar
        freeScalar.position = position1
        guard let value1 = freeScalar.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position1 == value1)
    }
    
    func testFreePoint() {
        // Constants
        let position0 = Spot(x: 0.25, y: 3.481)
        let position1 = Spot(x: 20.31, y: 18.456)
        // Create free point
        let freePoint = FreePoint(at: position0)
        guard let value0 = freePoint.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position0 == value0)
        // Move free point
        freePoint.position = position1
        guard let value1 = freePoint.value.value else {
            XCTFail()
            return
        }
        XCTAssert(position1 == value1)
    }
    
//    func testLine2Points() {
//        // Constants
//        let freePoint0 = FreePoint(at: CGPoint(x: 3234.234, y: 4597.234))
//        let freePoint1 = FreePoint(at: CGPoint(x: 90923.1, y: 9343.546))
//        let failPoint0 = FailPoint(.complex)
//        let failPoint1 = FailPoint(.none)
//        // Create regular line
//        let line0 = Line2Points(freePoint0, freePoint1)
//    }
    
}
