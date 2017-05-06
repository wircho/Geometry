//
//  CGMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

// MARK: Operators

infix operator • : MultiplicationPrecedence
infix operator ~/ : MultiplicationPrecedence

// MARK: Operations

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: CGPoint) -> CGPoint {
    return CGPoint(x: -point.x, y: -point.y)
}

func *(lhs: CGFloat, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: rhs * lhs.x, y: rhs * lhs.y)
}

func squareDistance(_ point0: CGPoint, _ point1: CGPoint) -> CGFloat {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: CGPoint, _ point1: CGPoint) -> CGFloat {
    return (point0 - point1).norm
}

func +(lhs: CG2x2, rhs: CG2x2) -> CG2x2 {
    return CG2x2(a00: lhs.a00 + rhs.a00, a01: lhs.a01 + rhs.a01, a10: lhs.a10 + rhs.a10, a11: lhs.a11 + rhs.a11)
}

func -(lhs: CG2x2, rhs: CG2x2) -> CG2x2 {
    return CG2x2(a00: lhs.a00 - rhs.a00, a01: lhs.a01 - rhs.a01, a10: lhs.a10 - rhs.a10, a11: lhs.a11 - rhs.a11)
}

prefix func -(m: CG2x2) -> CG2x2 {
    return CG2x2(a00: -m.a00, a01: -m.a01, a10: -m.a10, a11: -m.a11)
}

func *(lhs: CG2x2, rhs: CG2x2) -> CG2x2 {
    return CG2x2(a00: lhs.a00 * rhs.a00 + lhs.a01 * rhs.a10, a01: lhs.a00 * rhs.a01 + lhs.a01 * rhs.a11, a10: lhs.a10 * rhs.a00 + lhs.a11 * rhs.a10, a11: lhs.a10 * rhs.a01 + lhs.a11 * rhs.a11)
}

func *(lhs: CGFloat, rhs: CG2x2) -> CG2x2 {
    return CG2x2(a00: lhs * rhs.a00, a01: lhs * rhs.a01, a10: lhs * rhs.a10, a11: lhs * rhs.a11)
}

func *(lhs: CG2x2, rhs: CGFloat) -> CG2x2 {
    return CG2x2(a00: rhs * lhs.a00, a01: rhs * lhs.a01, a10: rhs * lhs.a10, a11: rhs * lhs.a11)
}

func *(lhs: CG2x2, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.a00 * rhs.x + lhs.a01 * rhs.y, y: lhs.a10 * rhs.x + lhs.a11 * rhs.y)
}

func *(lhs: CG2x2, rhs: CG2) -> CG2 {
    return (lhs.a00 * rhs.0 + lhs.a01 * rhs.1, lhs.a10 * rhs.0 + lhs.a11 * rhs.1)
}

func •(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: CG2, rhs: CG2) -> CGFloat {
    return lhs.0 * rhs.0 + lhs.1 * rhs.1
}

func |(lhs: CGPoint, rhs: CGPoint) -> CG2x2 {
    return CG2x2(column0: lhs, column1: rhs)
}

func /(lhs: CGPoint, rhs: CGPoint) -> CG2x2 {
    return CG2x2(row0: lhs, row1: rhs)
}

// MARK: Protocol extensions

extension CGPointProtocol {
    var coordinates: CG2 {
        return (x, y)
    }
    var squaredNorm: CGFloat {
        return x * x + y * y
    }
    var norm: CGFloat {
        return sqrt(squaredNorm)
    }
}
