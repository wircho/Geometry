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
//let staticFloat0: GeometrySample.Float = 3944.23
//let staticFloat1: GeometrySample.Float = 92.1
//let staticSpot0 = Spot(x: 3234.234, y: 4597.234)
//let staticSpot1 = Spot(x: 90923.1, y: 9343.546)

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
//        let position0: GeometrySample.Float = 856.24
//        let position1: GeometrySample.Float = 83456.1524
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
//        let position0 = Spot(x: 0.25, y: 3.481)
//        let position1 = Spot(x: 20.31, y: 18.456)
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
//    func getFreeAndFailedPoints(spot0: Spot = staticSpot0, spot1: Spot = staticSpot1, closure: (((FreePoint, FreePoint), (FailPoint, FailPoint), (MathError, MathError)) -> Void)? = nil) {
//        let freePoint0 = FreePoint(at: spot0)
//        let freePoint1 = FreePoint(at: spot1)
//        let error0 = MathError.complex
//        let error1 = MathError.none
//        let failPoint0 = FailPoint(error0)
//        let failPoint1 = FailPoint(error1)
//        closure?((freePoint0, freePoint1), (failPoint0, failPoint1), (error0, error1))
//    }
//    
//    func getStraight2Points<T:Straight2Points>(spot0: Spot = staticSpot0, spot1: Spot = staticSpot1, closure:((T,T,T,T) -> Void)? = nil) where T: Straight2PointsWithSorting {
//        // Constants
//        getFreeAndFailedPoints(spot0: spot0, spot1: spot1) {
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
//    func testAllStraight2Points() {
//        getStraight2Points() { (_: Line2Points, _: Line2Points, _: Line2Points, _: Line2Points) in }
//        getStraight2Points() { (_: Segment, _: Segment, _: Segment, _: Segment) in }
//        getStraight2Points() { (_: Ray, _: Ray, _: Ray, _: Ray) in }
//    }
    
//    func testCircleWithRadius() {
//        let freePoint0 = FreePoint(at: Spot(x: 0.25, y: 3.481))
//        let freeScalar1 = FreeScalar(at: 83.49)
//        let circle0 =
//    }
}
