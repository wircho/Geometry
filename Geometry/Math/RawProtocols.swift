//
//  RawProtocols.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

// MARK: Protocols

protocol RawPointProtocol {
    associatedtype Value: RawValueProtocol
    // TODO: Figure out why this breaks a project: static var zero: Self { get }
    var x: Value { get }
    var y: Value { get }
    init(x: Value, y: Value)
}

protocol RawRectProtocol {
    associatedtype Point: RawPointProtocol
    var origin: Point { get }
    var width: Point.Value { get }
    var height: Point.Value { get }
    var minX: Point.Value { get }
    var minY: Point.Value { get }
    var maxX: Point.Value { get }
    var maxY: Point.Value { get }
    init(x: Point.Value, y: Point.Value, width: Point.Value, height: Point.Value)
}

protocol AngleProtocol {
    associatedtype Value: RawValueProtocol
    var value: Value { get }
    init (value: Value)
}

protocol RawCircleProtocol {
    associatedtype Point: RawPointProtocol
    var center: Point { get }
    var radius: Point.Value { get }
    init(center: Point, radius: Point.Value)
}

protocol RawArcProtocol {
    associatedtype Circle: RawCircleProtocol
    var circle: Circle { get }
    var angles: Two<Angle<Circle.Point.Value>> { get }
    var fromFirst: Bool { get }
    init(circle: Circle, angles: Two<Angle<Circle.Point.Value>>, fromFirst: Bool)
}

protocol ArrowProtocol {
    associatedtype Point: RawPointProtocol
    var points: (Point, Point) { get }
    init(points: (Point, Point))
}

protocol RawRulerProtocol {
    associatedtype Arrow: ArrowProtocol
    var kind: RulerKind { get }
    var arrow: Arrow { get }
    init(forcedKind: RulerKind, forcedArrow: Arrow)
}

protocol RawCurveProtocol {
    associatedtype Point: RawPointProtocol
    var point0: Point { get }
    var control0: Point { get }
    var control1: Point { get }
    var point1: Point { get }
    init(point0: Point, control0: Point, control1: Point, point1: Point)
}

protocol RawQuadCurveProtocol {
    associatedtype Point: RawPointProtocol
    var point0: Point { get }
    var control: Point { get }
    var point1: Point { get }
    init(point0: Point, control: Point, point1: Point)
}

protocol TwoByTwoProtocol {
    associatedtype T
    var a00: T { get }
    var a01: T { get }
    var a10: T { get }
    var a11: T { get }
    init(a00: T, a01: T, a10: T, a11: T)
}

protocol TwoProtocol {
    associatedtype T
    var v0: T { get }
    var v1: T { get }
    init(v0: T, v1: T)
}
