//
//  RawResult.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: Result types

typealias Res<T> = Result<T, MathError>

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
    typealias Res<T> = Result<T, Error>
    
    var x: Res<CGFloat> {
        return self.map { $0.x }
    }
    
    var y: Res<CGFloat> {
        return self.map { $0.y }
    }
    
    init (x: CGFloat, y: CGFloat) {
        self = .success(T(x: x, y: y))
    }
    
    init (x: Res<CGFloat>, y: Res<CGFloat>) {
        self = x.flatMap { x in return y.map { y in return T(x: x, y: y) } }
    }
    
    var squaredNorm: Res<CGFloat> {
        return map { $0.squaredNorm }
    }
    
    var norm: Res<CGFloat> {
        return map { $0.norm }
    }
    
    var orthogonal: Result<RawPoint, Error> {
        return self.map { $0.orthogonal }
    }
}

extension Result where T: RawCircleProtocol {
    var center: Res<RawPoint> {
        return self.map { $0.center }
    }
    
    var radius: Res<CGFloat> {
        return self.map { $0.radius }
    }
    
    init (center: RawPoint, radius: CGFloat) {
        self = .success(T(center: center, radius: radius))
    }
    
    init (center: Res<RawPoint>, radius: Res<CGFloat>) {
        self = center.flatMap { center in return radius.map { radius in return T(center: center, radius: radius) } }
    }
    
    init (center: Res<RawPoint>, point: Res<RawPoint>) {
        self = center.flatMap { center in return point.map { point in return T(center: center, point: point) } }
    }
}

extension Result where T: ArrowProtocol {
    var point0: Res<RawPoint> {
        return self.map { $0.points.0 }
    }
    
    var point1: Res<RawPoint> {
        return self.map { $0.points.1 }
    }
    
    var vector: Res<RawPoint> {
        return self.map { $0.vector }
    }
    
    init(points: (Res<RawPoint>, Res<RawPoint>)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(points: (p0, p1)) } }
    }
}

extension Result where T: RawRulerProtocol, Error: MathErrorProtocol {
    var arrow: Res<Arrow> {
        return self.map { $0.arrow }
    }
    
    init(kind: RawRuler.Kind, arrow: Res<Arrow>) {
        self = arrow.flatMap { Result(T(kind: kind, arrow: $0), orOther: .infinity) }
    }
    
    init(kind: RawRuler.Kind, points: (Res<RawPoint>, Res<RawPoint>)) {
        self = points.0.flatMap { p0 in points.1.flatMap { p1 in Result(T(kind: kind, arrow: Arrow(points: (p0,p1))), orOther: .infinity) } }
    }
}

extension Result where T: RawCurveProtocol {
    var point0: Res<RawPoint> { return map { $0.point0 } }
    var control0: Res<RawPoint> { return map { $0.control0 } }
    var control1: Res<RawPoint> { return map { $0.control1 } }
    var point1: Res<RawPoint> { return map { $0.point1 } }
    
    init(point0: Res<RawPoint>, control0: Res<RawPoint>, control1: Res<RawPoint>, point1: Res<RawPoint>) {
        self = point0.flatMap { p0 in control0.flatMap { c0 in control1.flatMap { c1 in point1.map { p1 in T(point0: p0, control0: c0, control1: c1, point1: p1) } } } }
    }
}

extension Result where T: RawQuadCurveProtocol {
    var point0: Res<RawPoint> { return map { $0.point0 } }
    var control: Res<RawPoint> { return map { $0.control } }
    var point1: Res<RawPoint> { return map { $0.point1 } }
    
    init(point0: Res<RawPoint>, control: Res<RawPoint>, point1: Res<RawPoint>) {
        self = point0.flatMap { p0 in control.flatMap { c in point1.map { p1 in T(point0: p0, control: c, point1: p1) } } }
    }
}

extension Result where T: RawQuadCurveProtocol {
    
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

