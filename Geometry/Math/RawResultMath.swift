//
//  _ResultMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-02.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result


// MARKL: Operations

func ~/(lhs: _Float, rhs: _Float) -> _FloatResult {
    let value = lhs / rhs
    return value.isInfinite ? .failure(MathError.infinity) : .success(value)
}

func +(lhs: _FloatResult, rhs: _FloatResult) -> _FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs + rhs } }
}

func -(lhs: _FloatResult, rhs: _FloatResult) -> _FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs - rhs } }
}

func *(lhs: _FloatResult, rhs: _FloatResult) -> _FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs * rhs } }
}

func /(lhs: _FloatResult, rhs: _FloatResult) -> _FloatResult {
    return lhs.flatMap { lhs in return rhs.flatMap { rhs in return lhs ~/ rhs } }
}

prefix func -(value: _FloatResult) -> _FloatResult {
    return value.map { -$0 }
}

func +(lhs: _PointResult, rhs: _PointResult) -> _PointResult {
    return _PointResult(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: _PointResult, rhs: _PointResult) -> _PointResult {
    return _PointResult(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: _PointResult) -> _PointResult {
    return _PointResult(x: -point.x, y: -point.y)
}

func *(lhs: _FloatResult, rhs: _PointResult) -> _PointResult {
    return _PointResult(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: _PointResult, rhs: _FloatResult) -> _PointResult {
    return _PointResult(x: rhs * lhs.x, y: rhs * lhs.y)
}

func /(lhs: _Point, rhs: _Float) -> _PointResult {
    return (lhs.x ~/ rhs).flatMap { x in (lhs.y ~/ rhs).map { y in _Point(x: x, y: y) } }
}

func /(lhs: _PointResult, rhs: _FloatResult) -> _PointResult {
    return _PointResult(x: lhs.x / rhs, y: lhs.y / rhs)
}

func •(lhs: _PointResult, rhs: _PointResult) -> _FloatResult {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: _Float2Result, rhs: _Float2Result) -> _FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs • rhs } }
}

func /(lhs: _TwoByTwo, rhs: _Float) -> _TwoByTwoResult {
    return (lhs.a00 ~/ rhs).flatMap { a00 in (lhs.a01 ~/ rhs).flatMap { a01 in (lhs.a10 ~/ rhs).flatMap { a10 in (lhs.a11 ~/ rhs).map { a11 in _TwoByTwo(a00: a00, a01: a01, a10: a10, a11: a11) } } } }
}

// MARK: Global functions

func squareDistance(_ point0: _PointResult, _ point1: _PointResult) -> _FloatResult {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: _PointResult, _ point1: _PointResult) -> _FloatResult {
    return (point0 - point1).norm
}

func sqrt(_ value: _FloatResult) -> _FloatResult {
    return value.flatMap {
        value in
        guard value >= 0 else {
            return .failure(MathError.complex)
        }
        return .success(sqrt(value))
    }
}

func intersectionCoordinates(_ arrow0: _Arrow, _ arrow1: _Arrow) -> _Float2Result {
    //(01 - 00) * alpha - (11 - 10) * beta =  10 - 00
    return (arrow0.at0 | -arrow1.at0).inverse.map { $0  * (arrow1.points.0 - arrow0.points.0).coordinates }
}

func intersection(_ arrow0: _Arrow, _ arrow1: _Arrow) -> _PointResult {
    return intersectionCoordinates(arrow0, arrow1).map { arrow0.points.0 + arrow0.at0 * $0.0 }
}

func intersection(_ straight0: _Straight, _ straight1: _Straight) -> _PointResult {
    return intersectionCoordinates(straight0.arrow, straight1.arrow).flatMap {
        coords in
        guard straight0.kind.covers(coords.0) && straight1.kind.covers(coords.1) else {
            return .none
        }
        return .success(straight0.arrow.at(coords.0))
    }
}

func intersection(_ straight0: _StraightResult, _ straight1: _StraightResult) -> _PointResult {
    return straight0.flatMap { s0 in return straight1.flatMap { s1 in return intersection(s0, s1) } }
}

func intersectionCoordinates(_ arrow: _Arrow, _ circle: _Circle) -> _Float2Result {
    return (1 ~/ arrow.at0.norm).flatMap {
        nRec in
        let c = (circle.center - arrow.points.0) • arrow.at0 * nRec
        let pc = arrow.at(c, multiplier: nRec)
        let dc = distance(pc, circle.center)
        guard dc <= circle.radius else {
            return .none
        }
        let e = sqrt(circle.radius * circle.radius - dc * dc)
        return .success((c - e) * nRec, (c + e) * nRec)
    }
    
}

func intersections(_ straight: _Straight, _ circle: _Circle) -> _Point2Result {
    return intersectionCoordinates(straight.arrow, circle).map {
        coords in
        return _Point2(
            first: straight.kind.covers(coords.0) ? straight.arrow.at(coords.0) : nil,
            second: straight.kind.covers(coords.1) ? straight.arrow.at(coords.1) : nil
        )
    }
}

func intersections(_ straight: _StraightResult, _ circle: _CircleResult) -> _Point2Result {
    return straight.flatMap { s in circle.flatMap { c in intersections(s,c) } }
}

// MARK: Protocol extensions

private extension _TwoByTwoProtocol {
    var inverse: _TwoByTwoResult {
        return _TwoByTwo(a00: a11, a01: -a01, a10: -a10, a11: a00) / determinant
    }
}

extension Result where T: _CircleProtocol, Error: MathErrorProtocol {
    init(cicumscribing points: (_Point, _Point, _Point)) {
        let d = 2 * ( points.0.x * (points.1.y - points.2.y)
            + points.1.x * (points.2.y - points.0.y)
            + points.2.x * (points.0.y - points.1.y)
        )
        let u = 2 * ( points.0.squaredNorm * (points.1 - points.2)
            + points.1.squaredNorm * (points.2 - points.0)
            + points.2.squaredNorm * (points.0 - points.1)
        )
        self = (_Point(x: u.y, y: -u.x) / d)
            .map {
                center in
                let radius = distance(center, points.0)
                return T(center: center, radius: radius)
            }
            .mapError { Error($0) }
    }
    
    init (cicumscribing points: (_PointResult, _PointResult, _PointResult)) {
        self = points.0.flatMap { p0 in return points.1.flatMap{ p1 in return points.2.flatMap { p2 in return Result(cicumscribing: (p0, p1, p2)) } } }
    }
}
