//
//  RawMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

// MARK: Operators

infix operator • : MultiplicationPrecedence
infix operator ~/ : MultiplicationPrecedence

// MARK: Operations

extension RawPointProtocol {
    static func +(lhs: Self, rhs: Self) -> Self {
        return Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        return Self(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static prefix func -(point: Self) -> Self {
        return Self(x: -point.x, y: -point.y)
    }
    
    static func *(lhs: Value, rhs: Self) -> Self {
        return Self(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    
    static func *(lhs: Self, rhs: Value) -> Self {
        return Self(x: rhs * lhs.x, y: rhs * lhs.y)
    }
    
    static func •(lhs: Self, rhs: Self) -> Value {
        return lhs.x * rhs.x + lhs.y * rhs.y
    }
    
    static func |(lhs: Self, rhs: Self) -> TwoByTwo<Value> {
        return TwoByTwo(column0: lhs.coordinates, column1: rhs.coordinates)
    }
    
    static func /(lhs: Self, rhs: Self) -> TwoByTwo<Value> {
        return TwoByTwo(row0: lhs.coordinates, row1: rhs.coordinates)
    }
    
    var coordinates: Two<Value> {
        return Two(v0: x, v1: y)
    }
    
    var squaredNorm: Value {
        return x * x + y * y
    }
    
    var norm: Value {
        return squaredNorm.squareRoot()
    }
    
    var orthogonal: Self {
        return Self(x: -y, y: x)
    }
}

extension TwoProtocol where T: RawValueProtocol {
    static func •(lhs: Self, rhs: Self) -> T {
        return lhs.v0 * rhs.v0 + lhs.v1 * rhs.v1
    }
}

extension TwoByTwoProtocol where T: RawValueProtocol {
    
    static func +(lhs: Self, rhs: Self) -> Self {
        return Self(a00: lhs.a00 + rhs.a00, a01: lhs.a01 + rhs.a01, a10: lhs.a10 + rhs.a10, a11: lhs.a11 + rhs.a11)
    }
    
    static func -(lhs: Self, rhs: Self) -> Self {
        return Self(a00: lhs.a00 - rhs.a00, a01: lhs.a01 - rhs.a01, a10: lhs.a10 - rhs.a10, a11: lhs.a11 - rhs.a11)
    }
    
    static prefix func -(m: Self) -> Self {
        return Self(a00: -m.a00, a01: -m.a01, a10: -m.a10, a11: -m.a11)
    }
    
    static func *(lhs: T, rhs: Self) -> Self {
        return Self(a00: lhs * rhs.a00, a01: lhs * rhs.a01, a10: lhs * rhs.a10, a11: lhs * rhs.a11)
    }
    
    static func *(lhs: Self, rhs: T) -> Self {
        return Self(a00: rhs * lhs.a00, a01: rhs * lhs.a01, a10: rhs * lhs.a10, a11: rhs * lhs.a11)
    }
    
    static func *<Point: RawPointProtocol>(lhs: Self, rhs: Point) -> Point where Point.Value == T {
        let x = lhs.a00 * rhs.x + lhs.a01 * rhs.y
        let y = lhs.a10 * rhs.x + lhs.a11 * rhs.y
        return Point(x: x, y: y)
    }
    
    static func *(lhs: Self, rhs: Two<T>) -> Two<T> {
        let v0 = lhs.a00 * rhs.v0 + lhs.a01 * rhs.v1
        let v1 = lhs.a10 * rhs.v0 + lhs.a11 * rhs.v1
        return Two(v0: v0, v1: v1)
    }
    
}

func distance<Point: RawPointProtocol>(_ point0: Point, _ point1: Point) -> Point.Value {
    return (point0 - point1).norm
}
