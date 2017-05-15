//
//  RawTypes.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

// MARK: - Typealiases

typealias Float = CGFloat
typealias RawPoint = CGPoint

// MARK: - New Types

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


struct Angle {
    var value: Float
    
    static var piValue = Float(M_PI)
    static var twoPiValue = Float(2 * M_PI)
    
    init (value: Float) {
        var val = value
        while val > Angle.piValue { val -= Angle.twoPiValue }
        while val <= -Angle.piValue { val += Angle.twoPiValue }
        self.value = val
    }
    
    func greaterValue(_ other: Angle) -> Float {
        var value1 = other.value
        while value1 < value { value1 += Angle.twoPiValue }
        return value1
    }
    
    func lesserValue(_ other: Angle) -> Float {
        var value1 = other.value
        while value1 > value { value1 -= Angle.twoPiValue }
        return value1
    }
}

struct RawCircle {
    var center: RawPoint
    var radius: Float
}

struct RawArc {
    var circle: RawCircle
    var angles: Two<Angle>
    var fromFirst: Bool
    
    var angleValues: Two<Float> {
        return Two(v0: angles.v0.value, v1: angles.v0.greaterValue(angles.v1))
    }
    
    var center: RawPoint {
        get { return circle.center }
        set { circle.center = newValue }
    }
    
    var radius: Float {
        get { return circle.radius }
        set { circle.radius = newValue }
    }
}

struct Arrow {
    var points: (RawPoint, RawPoint)
    var isPoint: Bool {
        return (1 / (points.0 - points.1).squaredNorm).isNaN
    }
}

struct RawRuler {
    enum Kind {
        case segment
        case line
        case ray
        func covers(_ value: Float) -> Bool {
            switch self {
            case .segment: return value >= 0 && value <= 1
            case .line: return true
            case .ray: return value >= 0
            }
        }
    }
    var kind: Kind
    var arrow: Arrow
    init?(kind: Kind, arrow: Arrow) {
        guard kind == .segment || !arrow.isPoint else {
            return nil
        }
        self.kind = kind
        self.arrow = arrow
    }
}

// MARK: Protocols
protocol FloatProtocol {
    static func *(lhs: Self, rhs: Self) -> Self
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static prefix func -(value: Self) -> Self
    var isNaN: Bool { get }
    var isInfinite: Bool { get }
}

protocol RawPointProtocol {
    var x: Float { get }
    var y: Float { get }
    init(x: Float, y: Float)
}

protocol RawCircleProtocol {
    var center: RawPoint { get }
    var radius: Float { get }
    init(center: RawPoint, radius: Float)
    init(center: RawPoint, point: RawPoint)
}

protocol RawArcProtocol {
    var circle: RawCircle { get }
    var angles: Two<Angle> { get }
    var fromFirst: Bool { get }
    init(circle: RawCircle, angles: Two<Angle>, fromFirst: Bool)
}

protocol ArrowProtocol {
    var points: (RawPoint, RawPoint) { get }
    init(points: (RawPoint, RawPoint))
}

protocol RawRulerProtocol {
    var kind: RawRuler.Kind { get }
    var arrow: Arrow { get }
    init?(kind: RawRuler.Kind, arrow: Arrow)
    init?(kind: RawRuler.Kind, points: (RawPoint, RawPoint))
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

extension Float: FloatProtocol {}
extension RawPoint: RawPointProtocol {
    var angle: Angle {
        return Angle(value: atan2(y, x))
    }
}
extension RawCircle: RawCircleProtocol {
    init(center: CGPoint, point: CGPoint) {
        self.init(center: center, radius: distance(center, point))
    }
}
extension RawArc: RawArcProtocol {}
extension Arrow: ArrowProtocol {}
extension RawRuler: RawRulerProtocol {
    init?(kind: RawRuler.Kind, points: (RawPoint, RawPoint)) {
        self.init(kind: kind, arrow: Arrow(points: points))
    }
}
extension TwoByTwo: TwoByTwoProtocol {}
extension Two: TwoProtocol { }

// MARK: Protocol extensions

extension ArrowProtocol {
    var vector: RawPoint {
        return points.1 - points.0
    }
    
    func at(_ v: Float) -> RawPoint {
        return points.0 + vector * v
    }
}

extension RawRulerProtocol {
    func segment(arrow: Arrow) -> Self? {
        return Self(kind: .segment, arrow: arrow)
    }
    
    func line(arrow: Arrow) -> Self? {
        return Self(kind: .line, arrow: arrow)
    }
    
    func ray(arrow: Arrow) -> Self? {
        return Self(kind: .ray, arrow: arrow)
    }
}

extension TwoByTwoProtocol {
    init (row0: Two<T>, row1: Two<T>) {
        self.init(a00: row0.v0, a01: row0.v1, a10: row1.v0, a11: row1.v1)
    }
    
    init (column0: Two<T>, column1: Two<T>) {
        self.init(a00: column0.v0, a01: column1.v0, a10: column0.v1, a11: column1.v1)
    }
}

extension TwoByTwoProtocol where T: FloatProtocol {
    var determinant: T {
        return a00 * a11 - a01 * a10
    }
}
