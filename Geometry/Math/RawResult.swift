//
//  RawResult.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: Result types

typealias FloatResult = Result<Float, MathError>
typealias RawPointResult = Result<RawPoint, MathError>
typealias RawCircleResult = Result<RawCircle, MathError>
typealias RawArcResult = Result<RawArc, MathError>
typealias ArrowResult = Result<Arrow, MathError>
typealias RawRulerResult = Result<RawRuler, MathError>
typealias TwoByTwoFloatResult = Result<TwoByTwo<Float>, MathError>
typealias TwoFloatResult = Result<Two<Float>, MathError>
typealias TwoRawPoint = Two<RawPoint>
typealias TwoRawPointResult = Result<TwoRawPoint, MathError>
typealias TwoOptionalRawPoint = Two<RawPoint?>
typealias TwoOptionalRawPointResult = Result<TwoOptionalRawPoint, MathError>
typealias TwoOptionalFloatResult = Result<Two<Float?>, MathError>


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

extension Result where T: RawPointProtocol {
    typealias FloatResult = Result<Float, Error>
    
    var x: FloatResult {
        return self.map { $0.x }
    }
    
    var y: FloatResult {
        return self.map { $0.y }
    }
    
    init (x: Float, y: Float) {
        self = .success(T(x: x, y: y))
    }
    
    init (x: FloatResult, y: FloatResult) {
        self = x.flatMap { x in return y.map { y in return T(x: x, y: y) } }
    }
    
    var squaredNorm: FloatResult {
        return map { $0.squaredNorm }
    }
    
    var norm: FloatResult {
        return map { $0.norm }
    }
    
    var orthogonal: Result<RawPoint, Error> {
        return self.map { $0.orthogonal }
    }
}

extension Result where T: RawCircleProtocol {
    typealias RawPointResult = Result<RawPoint, Error>
    
    var center: RawPointResult {
        return self.map { $0.center }
    }
    
    var radius: FloatResult {
        return self.map { $0.radius }
    }
    
    init (center: RawPoint, radius: Float) {
        self = .success(T(center: center, radius: radius))
    }
    
    init (center: RawPointResult, radius: FloatResult) {
        self = center.flatMap { center in return radius.map { radius in return T(center: center, radius: radius) } }
    }
    
    init (center: RawPointResult, point: RawPointResult) {
        self = center.flatMap { center in return point.map { point in return T(center: center, point: point) } }
    }
}

extension Result where T: ArrowProtocol {
    var point0: RawPointResult {
        return self.map { $0.points.0 }
    }
    
    var point1: RawPointResult {
        return self.map { $0.points.1 }
    }
    
    var vector: RawPointResult {
        return self.map { $0.vector }
    }
    
    init(points: (RawPointResult, RawPointResult)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(points: (p0, p1)) } }
    }
}

extension Result where T: RawRulerProtocol, Error: MathErrorProtocol {
    typealias ArrowResult = Result<Arrow, Error>
    
    var arrow: ArrowResult {
        return self.map { $0.arrow }
    }
    
    init(kind: RawRuler.Kind, arrow: ArrowResult) {
        self = arrow.flatMap { Result(T(kind: kind, arrow: $0), orOther: .infinity) }
    }
    
    init(kind: RawRuler.Kind, points: (RawPointResult, RawPointResult)) {
        self = points.0.flatMap { p0 in points.1.flatMap { p1 in Result(T(kind: kind, arrow: Arrow(points: (p0,p1))), orOther: .infinity) } }
    }
}

extension Result where T: TwoProtocol,  Error: MathErrorProtocol {
    var v0: Result<T.T,Error> {
        return self.map {
            return $0.v0
        }
    }
    
    var v1: Result<T.T,Error> {
        return self.map {
            return $0.v1
        }
    }
    
    init(v0: Result<T.T,Error>, v1: Result<T.T,Error>) {
        self = v0.flatMap { v0 in v1.map { v1 in T(v0: v0, v1: v1) } }
    }
}

extension ResultProtocol where Error: MathErrorProtocol {
    static var none: Self {
        return Self(error: Error(.none))
    }
    static var infinity: Self {
        return Self(error: Error(.infinity))
    }
}

