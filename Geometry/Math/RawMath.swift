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

func +(lhs: RawPoint, rhs: RawPoint) -> RawPoint {
    return RawPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: RawPoint, rhs: RawPoint) -> RawPoint {
    return RawPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: RawPoint) -> RawPoint {
    return RawPoint(x: -point.x, y: -point.y)
}

func *(lhs: CGFloat, rhs: RawPoint) -> RawPoint {
    return RawPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: RawPoint, rhs: CGFloat) -> RawPoint {
    return RawPoint(x: rhs * lhs.x, y: rhs * lhs.y)
}

func squareDistance(_ point0: RawPoint, _ point1: RawPoint) -> CGFloat {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: RawPoint, _ point1: RawPoint) -> CGFloat {
    return (point0 - point1).norm
}

func +(lhs: TwoByTwo<CGFloat>, rhs: TwoByTwo<CGFloat>) -> TwoByTwo<CGFloat> {
    return TwoByTwo<CGFloat>(a00: lhs.a00 + rhs.a00, a01: lhs.a01 + rhs.a01, a10: lhs.a10 + rhs.a10, a11: lhs.a11 + rhs.a11)
}

func -(lhs: TwoByTwo<CGFloat>, rhs: TwoByTwo<CGFloat>) -> TwoByTwo<CGFloat> {
    return TwoByTwo(a00: lhs.a00 - rhs.a00, a01: lhs.a01 - rhs.a01, a10: lhs.a10 - rhs.a10, a11: lhs.a11 - rhs.a11)
}

prefix func -(m: TwoByTwo<CGFloat>) -> TwoByTwo<CGFloat> {
    return TwoByTwo(a00: -m.a00, a01: -m.a01, a10: -m.a10, a11: -m.a11)
}

func *(lhs: TwoByTwo<CGFloat>, rhs: TwoByTwo<CGFloat>) -> TwoByTwo<CGFloat> {
    return TwoByTwo(a00: lhs.a00 * rhs.a00 + lhs.a01 * rhs.a10, a01: lhs.a00 * rhs.a01 + lhs.a01 * rhs.a11, a10: lhs.a10 * rhs.a00 + lhs.a11 * rhs.a10, a11: lhs.a10 * rhs.a01 + lhs.a11 * rhs.a11)
}

func *(lhs: CGFloat, rhs: TwoByTwo<CGFloat>) -> TwoByTwo<CGFloat> {
    return TwoByTwo(a00: lhs * rhs.a00, a01: lhs * rhs.a01, a10: lhs * rhs.a10, a11: lhs * rhs.a11)
}

func *(lhs: TwoByTwo<CGFloat>, rhs: CGFloat) -> TwoByTwo<CGFloat> {
    return TwoByTwo(a00: rhs * lhs.a00, a01: rhs * lhs.a01, a10: rhs * lhs.a10, a11: rhs * lhs.a11)
}

func *(lhs: TwoByTwo<CGFloat>, rhs: RawPoint) -> RawPoint {
    return RawPoint(x: lhs.a00 * rhs.x + lhs.a01 * rhs.y, y: lhs.a10 * rhs.x + lhs.a11 * rhs.y)
}

func *(lhs: TwoByTwo<CGFloat>, rhs: Two<CGFloat>) -> Two<CGFloat> {
    return Two(v0: lhs.a00 * rhs.v0 + lhs.a01 * rhs.v1, v1: lhs.a10 * rhs.v0 + lhs.a11 * rhs.v1)
}

func •(lhs: RawPoint, rhs: RawPoint) -> CGFloat {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: Two<CGFloat>, rhs: Two<CGFloat>) -> CGFloat {
    return lhs.v0 * rhs.v0 + lhs.v1 * rhs.v1
}

func |(lhs: RawPoint, rhs: RawPoint) -> TwoByTwo<CGFloat> {
    return TwoByTwo(column0: lhs.coordinates, column1: rhs.coordinates)
}

func /(lhs: RawPoint, rhs: RawPoint) -> TwoByTwo<CGFloat> {
    return TwoByTwo(row0: lhs.coordinates, row1: rhs.coordinates)
}

// MARK: Protocol extensions

extension RawPointProtocol {
    var coordinates: Two<CGFloat> {
        return Two(v0: x, v1: y)
    }
    var squaredNorm: CGFloat {
        return x * x + y * y
    }
    var norm: CGFloat {
        return sqrt(squaredNorm)
    }
    var orthogonal: RawPoint {
        return RawPoint(x: -y, y: x)
    }
}
