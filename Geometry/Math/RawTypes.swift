//
//  RawTypes.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Darwin

struct Two<T> {
    var v0:T
    var v1:T
}

struct TwoByTwo<T> {
    var a00: T
    var a01: T
    var a10: T
    var a11: T
}


struct Angle<Value: RawValueProtocol> {
    var value: Value
    
    init (value: Value) {
        var val = value
        while val > Value.pi { val -= Value.twoPi }
        while val <= -Value.pi { val += Value.twoPi }
        self.value = val
    }
    
    func greaterValue(_ other: Angle) -> Value {
        var value1 = other.value
        while value1 < value { value1 += Value.twoPi }
        return value1
    }
    
    func lesserValue(_ other: Angle) -> Value {
        var value1 = other.value
        while value1 > value { value1 -= Value.twoPi }
        return value1
    }
}


struct RawCircle<Point: RawPointProtocol> {
    var center: Point
    var radius: Point.Value
}

struct RawArc<Point: RawPointProtocol> {
    var circle: RawCircle<Point>
    var angles: Two<Angle<Point.Value>>
    var fromFirst: Bool
}

struct Arrow<Point: RawPointProtocol> {
    var points: (Point, Point)
}

enum RulerKind {
    case segment
    case line
    case ray
    func covers<Value: RawValueProtocol>(_ value: Value) -> Bool {
        switch self {
        case .segment: return value >= 0 && value <= 1
        case .line: return true
        case .ray: return value >= 0
        }
    }
}

struct RawRuler<Point: RawPointProtocol> {
    var kind: RulerKind
    var arrow: Arrow<Point>
    init(forcedKind: RulerKind, forcedArrow: Arrow<Point>) {
        self.kind = forcedKind
        self.arrow = forcedArrow
    }
}

struct RawCurve<Point: RawPointProtocol> {
    var point0: Point
    var control0: Point
    var control1: Point
    var point1: Point
}

struct RawQuadCurve<Point: RawPointProtocol> {
    var point0: Point
    var control: Point
    var point1: Point
}

struct RawPathSegment<Point: RawPointProtocol> {
    var point: Point
}

struct RawPathCurve<Point: RawPointProtocol> {
    var control0: Point
    var control1: Point
    var point1: Point
}

struct RawPathQuadCurve<Point: RawPointProtocol> {
    var control: Point
    var point1: Point
}

enum RawPathComponent<Point: RawPointProtocol> {
    case segment(RawPathSegment<Point>)
    case curve(RawPathCurve<Point>)
    case quadCurve(RawPathQuadCurve<Point>)
}

struct RawPath<Point: RawPointProtocol> {
    var start: Point
    var components: [RawPathComponent<Point>]
}

// MARK: Protocol comformance

extension Angle: AngleProtocol { }
extension RawCircle: RawCircleProtocol { }
extension Arrow: ArrowProtocol {}
extension RawRuler: RawRulerProtocol {}
extension RawArc: RawArcProtocol {}
extension RawCurve: RawCurveProtocol {}
extension RawQuadCurve: RawQuadCurveProtocol {}
extension TwoByTwo: TwoByTwoProtocol {}
extension Two: TwoProtocol { }

// MARK: Protocol extensions

extension TwoByTwoProtocol {
    init (row0: Two<T>, row1: Two<T>) {
        self.init(a00: row0.v0, a01: row0.v1, a10: row1.v0, a11: row1.v1)
    }
    
    init (column0: Two<T>, column1: Two<T>) {
        self.init(a00: column0.v0, a01: column1.v0, a10: column0.v1, a11: column1.v1)
    }
}

extension RawCircleProtocol {
    init(center: Point, point: Point) {
        self.init(center: center, radius: distance(center, point))
    }
}

extension RawRectProtocol {
    init(circle: RawCircle<Point>) {
        let side = 2 * circle.radius
        self.init(x: circle.center.x - circle.radius, y: circle.center.y - circle.radius, width: side, height: side)
    }
}
