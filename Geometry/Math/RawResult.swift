//
//  RawResult.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: Result types

typealias Res<T> = Result<T, MathError>

// MARK: Result extensions

extension Result {
    typealias Res<T> = Result<T, Error>
    
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
    var x: Res<T.Value> {
        return self.map { $0.x }
    }
    
    var y: Res<T.Value> {
        return self.map { $0.y }
    }
    
    init (x: T.Value, y: T.Value) {
        self = .success(T(x: x, y: y))
    }
    
    init (x: Res<T.Value>, y: Res<T.Value>) {
        self = x.flatMap { x in return y.map { y in return T(x: x, y: y) } }
    }
    
    var squaredNorm: Res<T.Value> {
        return map { $0.squaredNorm }
    }
    
    var norm: Res<T.Value> {
        return map { $0.norm }
    }
    
    var orthogonal: Res<T> {
        return self.map { $0.orthogonal }
    }
}


extension Result where T: RawCircleProtocol {
    var center: Res<T.Point> {
        return map { $0.center }
    }
    
    var radius: Res<T.Point.Value> {
        return self.map { $0.radius }
    }
    
    init (center: T.Point, radius: T.Point.Value) {
        self = .success(T(center: center, radius: radius))
    }
    
    init (center: Res<T.Point>, radius: Res<T.Point.Value>) {
        self = center.flatMap { center in return radius.map { radius in return T(center: center, radius: radius) } }
    }
    
    init (center: Res<T.Point>, point: Res<T.Point>) {
        self = center.flatMap { center in point.map { point in T(center: center, point: point) } }
    }
}


extension Result where T: ArrowProtocol {
    var point0: Res<T.Point> {
        return self.map { $0.points.0 }
    }
    
    var point1: Res<T.Point> {
        return self.map { $0.points.1 }
    }
    
    var vector: Res<T.Point> {
        return self.map { $0.vector }
    }
    
    init(points: (Res<T.Point>, Res<T.Point>)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(points: (p0, p1)) } }
    }
}

extension Result where T: RawRulerProtocol, Error: MathErrorProtocol {
    var arrow: Res<T.Arrow> {
        return self.map { $0.arrow }
    }
    
    init(kind: RulerKind, arrow: Res<T.Arrow>) {
        self = arrow.flatMap { Result(T(kind: kind, arrow: $0), orOther: .infinity) }
    }
    
    init(kind: RulerKind, points: (Res<T.Arrow.Point>, Res<T.Arrow.Point>)) {
        self = points.0.flatMap { p0 in points.1.flatMap { p1 in Result(T(kind: kind, arrow: T.Arrow(points: (p0,p1))), orOther: .infinity) } }
    }
}

extension Result where T: RawCurveProtocol {
    var point0: Res<T.Point> { return map { $0.point0 } }
    var control0: Res<T.Point> { return map { $0.control0 } }
    var control1: Res<T.Point> { return map { $0.control1 } }
    var point1: Res<T.Point> { return map { $0.point1 } }
    
    init(point0: Res<T.Point>, control0: Res<T.Point>, control1: Res<T.Point>, point1: Res<T.Point>) {
        self = point0.flatMap { p0 in control0.flatMap { c0 in control1.flatMap { c1 in point1.map { p1 in T(point0: p0, control0: c0, control1: c1, point1: p1) } } } }
    }
}

extension Result where T: RawQuadCurveProtocol {
    var point0: Res<T.Point> { return map { $0.point0 } }
    var control: Res<T.Point> { return map { $0.control } }
    var point1: Res<T.Point> { return map { $0.point1 } }
    
    init(point0: Res<T.Point>, control: Res<T.Point>, point1: Res<T.Point>) {
        self = point0.flatMap { p0 in control.flatMap { c in point1.map { p1 in T(point0: p0, control: c, point1: p1) } } }
    }
}

extension Result where T: TwoProtocol {
    var v0: Res<T.T> {
        return self.map {
            return $0.v0
        }
    }
    
    var v1: Res<T.T> {
        return self.map {
            return $0.v1
        }
    }
    
    init(v0: Res<T.T>, v1: Res<T.T>) {
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
    static var complex: Self {
        return Self(error: Error(.complex))
    }
}


