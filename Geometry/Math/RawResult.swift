//
//  RawResult.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: Result types

typealias _FloatResult = Result<_Float, MathError>
typealias _PointResult = Result<_Point, MathError>
typealias _CircleResult = Result<_Circle, MathError>
typealias _ArrowResult = Result<_Arrow, MathError>
typealias _StraightResult = Result<_Straight, MathError>
typealias _TwoByTwoResult = Result<_TwoByTwo, MathError>
typealias _Float2Result = Result<_Float2, MathError>
typealias _Point2Result = Result<_Point2, MathError>


// MARK: Result extensions

extension Result {
    init(_ value: T?, orError: Error) {
        guard let value = value else {
            self = .failure(orError)
            return
        }
        self = .success(value)
    }
    
    init(_ value: T?, orOther: Result) {
        guard let value = value else {
            self = orOther
            return
        }
        self = .success(value)
    }
}

extension Result where T: _PointProtocol {
    typealias _FloatResult = Result<_Float, Error>
    
    var x: _FloatResult {
        return self.map { $0.x }
    }
    
    var y: _FloatResult {
        return self.map { $0.y }
    }
    
    init (x: _Float, y: _Float) {
        self = .success(T(x: x, y: y))
    }
    
    init (x: _FloatResult, y: _FloatResult) {
        self = x.flatMap { x in return y.map { y in return T(x: x, y: y) } }
    }
    
    var squaredNorm: _FloatResult {
        return map { $0.squaredNorm }
    }
    
    var norm: _FloatResult {
        return map { $0.norm }
    }
}

extension Result where T: _CircleProtocol {
    typealias _PointResult = Result<_Point, Error>
    
    var center: _PointResult {
        return self.map { $0.center }
    }
    
    var radius: _FloatResult {
        return self.map { $0.radius }
    }
    
    init (center: _Point, radius: _Float) {
        self = .success(T(center: center, radius: radius))
    }
    
    init (center: _PointResult, radius: _FloatResult) {
        self = center.flatMap { center in return radius.map { radius in return T(center: center, radius: radius) } }
    }
    
    init (center: _PointResult, point: _PointResult) {
        self = center.flatMap { center in return point.map { point in return T(center: center, point: point) } }
    }
}

extension Result where T: _ArrowProtocol {
    var point0: _PointResult {
        return self.map { $0.points.0 }
    }
    
    var point1: _PointResult {
        return self.map { $0.points.1 }
    }
    
    init(points: (_PointResult, _PointResult)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(points: (p0, p1)) } }
    }
}

extension Result where T: _StraightProtocol, Error: MathErrorProtocol {
    typealias _ArrowResult = Result<_Arrow, Error>
    
    init(kind: _Straight.Kind, arrow: _ArrowResult) {
        self = arrow.flatMap { Result(T(kind: kind, arrow: $0), orOther: .infinity) }
    }
    
    init(kind: _Straight.Kind, points: (_PointResult, _PointResult)) {
        self = points.0.flatMap { p0 in points.1.flatMap { p1 in Result(T(kind: kind, arrow: _Arrow(points: (p0,p1))), orOther: .infinity) } }
    }
}

extension Result where T: _Point2Protocol,  Error: MathErrorProtocol {
    var first: _PointResult {
        return self.flatMap {
            guard let first = $0.first else {
                return .none
            }
            return .success(first)
        }
    }
    
    var second: _PointResult {
        return self.flatMap {
            guard let second = $0.second else {
                return .none
            }
            return .success(second)
        }
    }
}

extension Result where Error: MathErrorProtocol {
    static var none: Result {
        return .failure(Error(.none))
    }
    static var infinity: Result {
        return .failure(Error(.infinity))
    }
}

