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

//class FailPoint: Point {
//    private var failure: MathError
//    
//    init(_ failure: MathError) {
//        self.failure = failure
//        super.init()
//    }
//    
//    override func recalculate() -> Result<CGPoint, MathError> {
//        return .failure(failure)
//    }
//}
//
//let staticFloat0: GeometrySample.CGFloat = 3944.23
//let staticFloat1: GeometrySample.CGFloat = 92.1
//let staticRawPoint0 = RawPoint(x: 3234.234, y: 4597.234)
//let staticRawPoint1 = RawPoint(x: 90923.1, y: 9343.546)

class GeometrySampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testFreeScalar() {
//        // Constants
//        let position0: GeometrySample.CGFloat = 856.24
//        let position1: GeometrySample.CGFloat = 83456.1524
//        // Create free scalar
//        let freeScalar = FreeScalar(at: position0)
//        guard let value0 = freeScalar.result.value else {
//            XCTFail()
//            return
//        }
//        XCTAssert(position0 == value0)
//        // Move free scalar
//        freeScalar.position = position1
//        guard let value1 = freeScalar.result.value else {
//            XCTFail()
//            return
//        }
//        XCTAssert(position1 == value1)
//    }
//    
//    func testFreePoint() {
//        // Constants
//        let position0 = RawPoint(x: 0.25, y: 3.481)
//        let position1 = RawPoint(x: 20.31, y: 18.456)
//        // Create free point
//        let freePoint = FreePoint(at: position0)
//        guard let value0 = freePoint.result.value else {
//            XCTFail()
//            return
//        }
//        XCTAssert(position0 == value0)
//        // Move free point
//        freePoint.position = position1
//        guard let value1 = freePoint.result.value else {
//            XCTFail()
//            return
//        }
//        XCTAssert(position1 == value1)
//    }
//    
//    func getFreeAndFailedPoints(RawPoint0: RawPoint = staticRawPoint0, RawPoint1: RawPoint = staticRawPoint1, closure: (((FreePoint, FreePoint), (FailPoint, FailPoint), (MathError, MathError)) -> Void)? = nil) {
//        let freePoint0 = FreePoint(at: RawPoint0)
//        let freePoint1 = FreePoint(at: RawPoint1)
//        let error0 = MathError.complex
//        let error1 = MathError.none
//        let failPoint0 = FailPoint(error0)
//        let failPoint1 = FailPoint(error1)
//        closure?((freePoint0, freePoint1), (failPoint0, failPoint1), (error0, error1))
//    }
//    
//    func getRuler2Points<T:Ruler2Points>(RawPoint0: RawPoint = staticRawPoint0, RawPoint1: RawPoint = staticRawPoint1, closure:((T,T,T,T) -> Void)? = nil) where T: Ruler2PointsWithSorting {
//        // Constants
//        getFreeAndFailedPoints(RawPoint0: RawPoint0, RawPoint1: RawPoint1) {
//            free, fail, error in
//            
//            // Regular line
//            let line0 = T(free.0, free.1)
//            XCTAssert(
//                line0.result.value?.arrow.points.0 == free.0.result.value! && line0.result.value?.arrow.points.1 == free.1.result.value!
//            )
//            // Regular line to error
//            let line1 = T(free.0, fail.0)
//            XCTAssert(
//                line1.result.error == error.0
//            )
//            // Regular line from error
//            let line2 = T(fail.1, free.1)
//            XCTAssert(
//                line2.result.error == error.1
//            )
//            // Regular line from and to error
//            let line3 = T(fail.0, fail.1)
//            XCTAssert(
//                line3.result.error == error.0
//            )
//            
//            closure?(line0, line1, line2, line3)
//        }
//    }
//    
//    func testAllRuler2Points() {
//        getRuler2Points() { (_: Line2Points, _: Line2Points, _: Line2Points, _: Line2Points) in }
//        getRuler2Points() { (_: Segment, _: Segment, _: Segment, _: Segment) in }
//        getRuler2Points() { (_: Ray, _: Ray, _: Ray, _: Ray) in }
//    }
    
//    func testCircleWithRadius() {
//        let freePoint0 = FreePoint(at: RawPoint(x: 0.25, y: 3.481))
//        let freeScalar1 = FreeScalar(at: 83.49)
//        let circle0 =
//    }
}
