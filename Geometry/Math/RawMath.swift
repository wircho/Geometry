//
//  RawMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

// MARK: Operators

infix operator • : MultiplicationPrecedence
infix operator ~/ : MultiplicationPrecedence

// MARK: Operations

func +(lhs: _Point, rhs: _Point) -> _Point {
    return _Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: _Point, rhs: _Point) -> _Point {
    return _Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: _Point) -> _Point {
    return _Point(x: -point.x, y: -point.y)
}

func *(lhs: _Float, rhs: _Point) -> _Point {
    return _Point(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: _Point, rhs: _Float) -> _Point {
    return _Point(x: rhs * lhs.x, y: rhs * lhs.y)
}

func squareDistance(_ point0: _Point, _ point1: _Point) -> _Float {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: _Point, _ point1: _Point) -> _Float {
    return (point0 - point1).norm
}

func +(lhs: _TwoByTwo, rhs: _TwoByTwo) -> _TwoByTwo {
    return _TwoByTwo(a00: lhs.a00 + rhs.a00, a01: lhs.a01 + rhs.a01, a10: lhs.a10 + rhs.a10, a11: lhs.a11 + rhs.a11)
}

func -(lhs: _TwoByTwo, rhs: _TwoByTwo) -> _TwoByTwo {
    return _TwoByTwo(a00: lhs.a00 - rhs.a00, a01: lhs.a01 - rhs.a01, a10: lhs.a10 - rhs.a10, a11: lhs.a11 - rhs.a11)
}

prefix func -(m: _TwoByTwo) -> _TwoByTwo {
    return _TwoByTwo(a00: -m.a00, a01: -m.a01, a10: -m.a10, a11: -m.a11)
}

func *(lhs: _TwoByTwo, rhs: _TwoByTwo) -> _TwoByTwo {
    return _TwoByTwo(a00: lhs.a00 * rhs.a00 + lhs.a01 * rhs.a10, a01: lhs.a00 * rhs.a01 + lhs.a01 * rhs.a11, a10: lhs.a10 * rhs.a00 + lhs.a11 * rhs.a10, a11: lhs.a10 * rhs.a01 + lhs.a11 * rhs.a11)
}

func *(lhs: _Float, rhs: _TwoByTwo) -> _TwoByTwo {
    return _TwoByTwo(a00: lhs * rhs.a00, a01: lhs * rhs.a01, a10: lhs * rhs.a10, a11: lhs * rhs.a11)
}

func *(lhs: _TwoByTwo, rhs: _Float) -> _TwoByTwo {
    return _TwoByTwo(a00: rhs * lhs.a00, a01: rhs * lhs.a01, a10: rhs * lhs.a10, a11: rhs * lhs.a11)
}

func *(lhs: _TwoByTwo, rhs: _Point) -> _Point {
    return _Point(x: lhs.a00 * rhs.x + lhs.a01 * rhs.y, y: lhs.a10 * rhs.x + lhs.a11 * rhs.y)
}

func *(lhs: _TwoByTwo, rhs: _Float2) -> _Float2 {
    return (lhs.a00 * rhs.0 + lhs.a01 * rhs.1, lhs.a10 * rhs.0 + lhs.a11 * rhs.1)
}

func •(lhs: _Point, rhs: _Point) -> _Float {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: _Float2, rhs: _Float2) -> _Float {
    return lhs.0 * rhs.0 + lhs.1 * rhs.1
}

func |(lhs: _Point, rhs: _Point) -> _TwoByTwo {
    return _TwoByTwo(column0: lhs, column1: rhs)
}

func /(lhs: _Point, rhs: _Point) -> _TwoByTwo {
    return _TwoByTwo(row0: lhs, row1: rhs)
}

// MARK: Protocol extensions

extension _PointProtocol {
    var coordinates: _Float2 {
        return (x, y)
    }
    var squaredNorm: _Float {
        return x * x + y * y
    }
    var norm: _Float {
        return sqrt(squaredNorm)
    }
}
