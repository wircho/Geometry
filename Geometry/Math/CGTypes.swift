//
//  CGTypes.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

// MARK: New types

struct CGCircle {
    var center: CGPoint
    var radius: CGFloat
}

struct CGArrow {
    var points: (CGPoint, CGPoint)
}

struct CGStraight {
    enum Kind {
        case segment
        case line
        case ray
        func covers(_ value: CGFloat) -> Bool {
            switch self {
            case .segment: return value >= 0 && value <= 1
            case .line: return true
            case .ray: return value >= 0
            }
        }
    }
    var kind: Kind
    var arrow: CGArrow
}

struct CG2x2 {
    var a00: CGFloat
    var a01: CGFloat
    var a10: CGFloat
    var a11: CGFloat
}

typealias CG2 = (CGFloat, CGFloat)

struct CGPoint2 {
    var first: CGPoint?
    var second: CGPoint?
}

// MARK: Protocols

protocol CGFloatProtocol { }

protocol CGPointProtocol {
    var x: CGFloat { get }
    var y: CGFloat { get }
    init(x: CGFloat, y: CGFloat)
}

protocol CGCircleProtocol {
    var center: CGPoint { get }
    var radius: CGFloat { get }
    init(center: CGPoint, radius: CGFloat)
    init(center: CGPoint, point: CGPoint)
}

protocol CGArrowProtocol {
    var points: (CGPoint, CGPoint) { get }
    init(points: (CGPoint, CGPoint))
}

protocol CGStraightProtocol {
    var kind: CGStraight.Kind { get }
    var arrow: CGArrow { get }
    init(kind: CGStraight.Kind, arrow: CGArrow)
    init(kind: CGStraight.Kind, points: (CGPoint, CGPoint))
}

protocol CG2x2Protocol {
    var a00: CGFloat { get }
    var a01: CGFloat { get }
    var a10: CGFloat { get }
    var a11: CGFloat { get }
    init(a00: CGFloat, a01: CGFloat, a10: CGFloat, a11: CGFloat)
}

protocol CGPoint2Protocol {
    var first: CGPoint? { get }
    var second: CGPoint? { get }
    init(first: CGPoint?, second: CGPoint?)
}

extension CGFloat: CGFloatProtocol {}
extension CGPoint: CGPointProtocol {}
extension CGCircle: CGCircleProtocol {
    init(center: CGPoint, point: CGPoint) {
        self.init(center: center, radius: distance(center, point))
    }
}
extension CGArrow: CGArrowProtocol {}
extension CGStraight: CGStraightProtocol {
    init(kind: CGStraight.Kind, points: (CGPoint, CGPoint)) {
        self.init(kind: kind, arrow: CGArrow(points: points))
    }
}
extension CG2x2: CG2x2Protocol {}
extension CGPoint2: CGPoint2Protocol { }

// MARK: Protocol extensions

extension CGArrowProtocol {
    var at0: CGPoint {
        return points.1 - points.0
    }
    
    func at(_ v: CGFloat) -> CGPoint {
        return points.0 + at0 * v
    }
    
    func at(_ v: CGFloat, multiplier: CGFloat) -> CGPoint {
        return points.0 + at0 * v * multiplier
    }
}

extension CGStraightProtocol {
    func segment(arrow: CGArrow) -> Self {
        return Self(kind: .segment, arrow: arrow)
    }
    
    func line(arrow: CGArrow) -> Self {
        return Self(kind: .line, arrow: arrow)
    }
    
    func ray(arrow: CGArrow) -> Self {
        return Self(kind: .ray, arrow: arrow)
    }
}

extension CG2x2Protocol {
    init (row0: CGPoint, row1: CGPoint) {
        self.init(a00: row0.x, a01: row0.y, a10: row1.x, a11: row1.y)
    }
    
    init (column0: CGPoint, column1: CGPoint) {
        self.init(a00: column0.x, a01: column1.x, a10: column0.y, a11: column1.y)
    }
    
    var determinant: CGFloat {
        return a00 * a11 - a01 * a11
    }
}
