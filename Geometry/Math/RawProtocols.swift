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
    associatedtype Value
    associatedtype Point: RawPointProtocol where Point.Value == Value
    var origin: Point { get }
    var width: Value { get }
    var height: Value { get }
    var minX: Value { get }
    var minY: Value { get }
    var maxX: Value { get }
    var maxY: Value { get }
    init(x: Value, y: Value, width: Value, height: Value)
}

protocol AngleProtocol {
    associatedtype Value: RawValueProtocol
    var value: Value { get }
    init (value: Value)
    func greaterValue(_ other: Self) -> Value
}

protocol RawCircleProtocol {
    associatedtype Value
    associatedtype Point: RawPointProtocol where Point.Value == Value
    var center: Point { get }
    var radius: Value { get }
    init(center: Point, radius: Value)
}

protocol RawArcProtocol {
    associatedtype TwoAngles: TwoProtocol where TwoAngles.T: AngleProtocol
    associatedtype Circle: RawCircleProtocol where Circle.Point.Value == TwoAngles.T.Value
    var circle: Circle { get }
    var angles: TwoAngles { get }
    var fromFirst: Bool { get }
    init(circle: Circle, angles: TwoAngles, fromFirst: Bool)
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
