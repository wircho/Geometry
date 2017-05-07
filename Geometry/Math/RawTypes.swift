//
//  RawTypes.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

    // MARK: - Typealiases
    
    typealias _Float = CGFloat
    typealias _Point = CGPoint
    typealias _Float2 = (CGFloat, CGFloat)
    
    // MARK: - New Types
    
    struct _Circle {
        var center: _Point
        var radius: _Float
    }
    
    struct _Arrow {
        var points: (_Point, _Point)
        var isPoint: Bool {
            return (1 / (points.0 - points.1).squaredNorm).isNaN
        }
    }
    
    struct _Straight {
        enum Kind {
            case segment
            case line
            case ray
            func covers(_ value: _Float) -> Bool {
                switch self {
                case .segment: return value >= 0 && value <= 1
                case .line: return true
                case .ray: return value >= 0
                }
            }
        }
        var kind: Kind
        var arrow: _Arrow
        init?(kind: Kind, arrow: _Arrow) {
            guard kind == .segment || !arrow.isPoint else {
                return nil
            }
            self.kind = kind
            self.arrow = arrow
        }
    }
    
    struct _TwoByTwo {
        var a00: _Float
        var a01: _Float
        var a10: _Float
        var a11: _Float
    }
    
    struct _Point2 {
        var first: _Point?
        var second: _Point?
    }

// MARK: Protocols
protocol _FloatProtocol { }

protocol _PointProtocol {
    var x: _Float { get }
    var y: _Float { get }
    init(x: _Float, y: _Float)
}

protocol _CircleProtocol {
    var center: _Point { get }
    var radius: _Float { get }
    init(center: _Point, radius: _Float)
    init(center: _Point, point: _Point)
}

protocol _ArrowProtocol {
    var points: (_Point, _Point) { get }
    init(points: (_Point, _Point))
}

protocol _StraightProtocol {
    var kind: _Straight.Kind { get }
    var arrow: _Arrow { get }
    init?(kind: _Straight.Kind, arrow: _Arrow)
    init?(kind: _Straight.Kind, points: (_Point, _Point))
}

protocol _TwoByTwoProtocol {
    var a00: _Float { get }
    var a01: _Float { get }
    var a10: _Float { get }
    var a11: _Float { get }
    init(a00: _Float, a01: _Float, a10: _Float, a11: _Float)
}

protocol _Point2Protocol {
    var first: _Point? { get }
    var second: _Point? { get }
    init(first: _Point?, second: _Point?)
}

extension _Float: _FloatProtocol {}
extension _Point: _PointProtocol {}
extension _Circle: _CircleProtocol {
    init(center: CGPoint, point: CGPoint) {
        self.init(center: center, radius: distance(center, point))
    }
}
extension _Arrow: _ArrowProtocol {}
extension _Straight: _StraightProtocol {
    init?(kind: _Straight.Kind, points: (_Point, _Point)) {
        self.init(kind: kind, arrow: _Arrow(points: points))
    }
}
extension _TwoByTwo: _TwoByTwoProtocol {}
extension _Point2: _Point2Protocol { }

// MARK: Protocol extensions

extension _ArrowProtocol {
    var at0: _Point {
        return points.1 - points.0
    }
    
    func at(_ v: _Float) -> _Point {
        return points.0 + at0 * v
    }
    
    func at(_ v: _Float, multiplier: _Float) -> _Point {
        return points.0 + at0 * v * multiplier
    }
}

extension _StraightProtocol {
    func segment(arrow: _Arrow) -> Self? {
        return Self(kind: .segment, arrow: arrow)
    }
    
    func line(arrow: _Arrow) -> Self? {
        return Self(kind: .line, arrow: arrow)
    }
    
    func ray(arrow: _Arrow) -> Self? {
        return Self(kind: .ray, arrow: arrow)
    }
}

extension _TwoByTwoProtocol {
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
