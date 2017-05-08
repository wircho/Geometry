//
//  RawTypes.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

// MARK: - Typealiases

typealias Float = CGFloat
typealias Spot = CGPoint

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

struct Ring {
    var center: Spot
    var radius: Float
}

struct Arrow {
    var points: (Spot, Spot)
    var isPoint: Bool {
        return (1 / (points.0 - points.1).squaredNorm).isNaN
    }
}

struct Saber {
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

protocol SpotProtocol {
    var x: Float { get }
    var y: Float { get }
    init(x: Float, y: Float)
}

protocol RingProtocol {
    var center: Spot { get }
    var radius: Float { get }
    init(center: Spot, radius: Float)
    init(center: Spot, point: Spot)
}

protocol ArrowProtocol {
    var points: (Spot, Spot) { get }
    init(points: (Spot, Spot))
}

protocol SaberProtocol {
    var kind: Saber.Kind { get }
    var arrow: Arrow { get }
    init?(kind: Saber.Kind, arrow: Arrow)
    init?(kind: Saber.Kind, points: (Spot, Spot))
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
extension Spot: SpotProtocol {}
extension Ring: RingProtocol {
    init(center: CGPoint, point: CGPoint) {
        self.init(center: center, radius: distance(center, point))
    }
}
extension Arrow: ArrowProtocol {}
extension Saber: SaberProtocol {
    init?(kind: Saber.Kind, points: (Spot, Spot)) {
        self.init(kind: kind, arrow: Arrow(points: points))
    }
}
extension TwoByTwo: TwoByTwoProtocol {}
extension Two: TwoProtocol { }

// MARK: Protocol extensions

extension ArrowProtocol {
    var at0: Spot {
        return points.1 - points.0
    }
    
    func at(_ v: Float) -> Spot {
        return points.0 + at0 * v
    }
    
    func at(_ v: Float, multiplier: Float) -> Spot {
        return points.0 + at0 * v * multiplier
    }
}

extension SaberProtocol {
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
        self.init(a00: column0.v0, a01: column1.v1, a10: column0.v0, a11: column1.v1)
    }
}

extension TwoByTwoProtocol where T: FloatProtocol {
    var determinant: T {
        return a00 * a11 - a01 * a11
    }
}
