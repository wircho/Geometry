//
//  RawExtensions.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

extension RawPointProtocol {
    var angleValue: Value {
        return y.arctangent2(x)
    }
    
    var angle: Angle<Value> {
        return Angle(value: angleValue)
    }
}

extension AngleProtocol {
    init<Point: RawPointProtocol>(vector: Point) where Point.Value == Value {
        self.init(value: vector.angleValue)
    }
    
    func vector<Point: RawPointProtocol>(radius: Value) -> Point where Point.Value == Value {
        return Point(x: radius * value.cosine(), y: radius * value.sine())
    }
}

extension ArrowProtocol {
    var vector: Point {
        return points.1 - points.0
    }
    
    func at(offset: Point.Value) -> Point {
        return points.0 + vector * offset
    }
    
    var isPoint: Bool {
        return (1 / (points.0 - points.1).squaredNorm).isNaN
    }
}

extension RawRulerProtocol {
    init?(kind: RulerKind, arrow: Arrow) {
        guard kind == .segment || !arrow.isPoint else {
            return nil
        }
        self.init(forcedKind: kind, forcedArrow: arrow)
    }
    
    init?(kind: RulerKind, points: (Arrow.Point, Arrow.Point)) {
        self.init(kind: kind, arrow: Arrow(points: points))
    }
}

extension RawArcProtocol {
    var angleValues: Two<Circle.Point.Value> {
        return Two(v0: angles.v0.value, v1: angles.v0.greaterValue(angles.v1))
    }
    var center: Circle.Point { return circle.center }
    var radius: Circle.Point.Value { return circle.radius }
}

extension RawCurveProtocol {
    func at(offset: Point.Value) -> Point {
        let oneMinusPos = 1 - offset
        let pos2 = offset * offset
        let oneMinusPos2 = oneMinusPos * oneMinusPos
        let pos3 = pos2 * offset
        let oneMinusPos3 = oneMinusPos2 * oneMinusPos
        let term0 = oneMinusPos3 * point0
        let term1 = 3 * oneMinusPos2 * offset * control0
        let term2 = 3 * oneMinusPos * pos2 * control1
        let term3 = pos3 * point1
        return term0 + term1 + term2 + term3
    }
}

extension RawQuadCurveProtocol {
    func at(offset: Point.Value) -> Point {
        let oneMinusPos = 1 - offset
        let pos2 = offset * offset
        let oneMinusPos2 = oneMinusPos * oneMinusPos
        let term0 = oneMinusPos2 * point0
        let term1 = 2 * oneMinusPos * offset * control
        let term2 = pos2 * point1
        return term0 + term1 + term2
    }
}

extension TwoByTwoProtocol where T: RawValueProtocol {
    var determinant: T {
        return a00 * a11 - a01 * a10
    }
}
