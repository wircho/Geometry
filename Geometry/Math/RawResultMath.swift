//
//  _ResultMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-02.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result


// MARKL: Operations

func ~/<T: FloatProtocol>(lhs: T, rhs: T) -> Result<T, MathError> {
    let value = lhs / rhs
    return value.isInfinite ? .failure(MathError.infinity) : .success(value)
}

func +(lhs: FloatResult, rhs: FloatResult) -> FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs + rhs } }
}

func -(lhs: FloatResult, rhs: FloatResult) -> FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs - rhs } }
}

func *(lhs: FloatResult, rhs: FloatResult) -> FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs * rhs } }
}

func /(lhs: FloatResult, rhs: FloatResult) -> FloatResult {
    return lhs.flatMap { lhs in return rhs.flatMap { rhs in return lhs ~/ rhs } }
}

prefix func -(value: FloatResult) -> FloatResult {
    return value.map { -$0 }
}

func +(lhs: SpotResult, rhs: SpotResult) -> SpotResult {
    return SpotResult(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: SpotResult, rhs: SpotResult) -> SpotResult {
    return SpotResult(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: SpotResult) -> SpotResult {
    return SpotResult(x: -point.x, y: -point.y)
}

func *(lhs: FloatResult, rhs: SpotResult) -> SpotResult {
    return SpotResult(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: SpotResult, rhs: FloatResult) -> SpotResult {
    return SpotResult(x: rhs * lhs.x, y: rhs * lhs.y)
}

func /(lhs: Spot, rhs: Float) -> SpotResult {
    return (lhs.x ~/ rhs).flatMap { x in (lhs.y ~/ rhs).map { y in Spot(x: x, y: y) } }
}

func /(lhs: SpotResult, rhs: FloatResult) -> SpotResult {
    return SpotResult(x: lhs.x / rhs, y: lhs.y / rhs)
}

func •(lhs: SpotResult, rhs: SpotResult) -> FloatResult {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: TwoFloatResult, rhs: TwoFloatResult) -> FloatResult {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs • rhs } }
}

func /<T: FloatProtocol>(lhs: TwoByTwo<T>, rhs: T) -> Result<TwoByTwo<T>, MathError> {
    return (lhs.a00 ~/ rhs).flatMap { a00 in (lhs.a01 ~/ rhs).flatMap { a01 in (lhs.a10 ~/ rhs).flatMap { a10 in (lhs.a11 ~/ rhs).map { a11 in TwoByTwo(a00: a00, a01: a01, a10: a10, a11: a11) } } } }
}

// MARK: Global functions

func squareDistance(_ point0: SpotResult, _ point1: SpotResult) -> FloatResult {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: SpotResult, _ point1: SpotResult) -> FloatResult {
    return (point0 - point1).norm
}

func sqrt(_ value: FloatResult) -> FloatResult {
    return value.flatMap {
        value in
        let s = sqrt(value)
        guard !s.isNaN else {
            return .failure(MathError.complex)
        }
        return .success(s)
    }
}

func intersectionCoordinates(_ arrow0: Arrow, _ arrow1: Arrow) -> TwoFloatResult {
    //(01 - 00) * alpha - (11 - 10) * beta =  10 - 00
    return (arrow0.vector | -arrow1.vector).inverse.map { $0 * (arrow1.points.0 - arrow0.points.0).coordinates }
}

func intersection(_ straight0: Saber, _ straight1: Saber) -> SpotResult {
    return intersectionCoordinates(straight0.arrow, straight1.arrow).flatMap {
        coords in
        guard straight0.kind.covers(coords.v0) && straight1.kind.covers(coords.v1) else {
            return .none
        }
        return .success(straight0.arrow.at(coords.v0))
    }
}

func intersection(_ straight0: SaberResult, _ straight1: SaberResult) -> SpotResult {
    return straight0.flatMap { s0 in return straight1.flatMap { s1 in return intersection(s0, s1) } }
}

func intersectionCoordinates(_ arrow: Arrow, _ circle: Ring) -> TwoFloatResult {
    return (1 ~/ arrow.vector.norm).flatMap {
        nRec in
        let c = (circle.center - arrow.points.0) • arrow.vector * nRec
        let pc = arrow.at(c * nRec)
        let dc = distance(pc, circle.center)
        guard dc <= circle.radius else {
            return .none
        }
        let e = sqrt(circle.radius * circle.radius - dc * dc)
        return .success(Two(v0: (c - e) * nRec, v1: (c + e) * nRec))
    }
    
}

func intersectionCoordinates(_ arrow: Arrow, _ rect: CGRect) -> TwoFloatResult {
    let vector = arrow.vector
    let minX = rect.minX
    let minY = rect.minY
    let maxX = rect.maxX
    let maxY = rect.maxY
    guard let minXC = ((minX - arrow.points.0.x) ~/ vector.x).value, let maxXC = ((maxX - arrow.points.0.x) ~/ vector.x).value else {
        guard arrow.points.0.x > minX && arrow.points.0.x < maxX else {
            return .none
        }
        guard let minYC = ((minY - arrow.points.0.y) ~/ vector.y).value, let maxYC = ((maxY - arrow.points.0.y) ~/ vector.y).value else {
            return .infinity
        }
        return .success(Two(v0: min(minYC, maxYC), v1: max(minYC, maxYC)))
    }
    guard let minYC = ((minY - arrow.points.0.y) ~/ vector.y).value, let maxYC = ((maxY - arrow.points.0.y) ~/ vector.y).value else {
        guard arrow.points.0.y > minY && arrow.points.0.y < maxY else {
            return .none
        }
        return .success(Two(v0: min(minXC, maxXC), v1: max(minXC, maxXC)))
    }
    let x0 = min(minXC, maxXC)
    let x1 = max(minXC, maxXC)
    let y0 = min(minYC, maxYC)
    let y1 = max(minYC, maxYC)
    guard x1 > y0 && y1 > x0 else {
        return .none
    }
    return .success(Two(v0: max(x0, y0), v1: min(x1, y1)))
}

func intersections(_ straight: Saber, _ circle: Ring) -> TwoOptionalSpotResult {
    return intersectionCoordinates(straight.arrow, circle).map {
        coords in
        return Two<Spot?>(
            v0: straight.kind.covers(coords.v0) ? straight.arrow.at(coords.v0) : nil,
            v1: straight.kind.covers(coords.v1) ? straight.arrow.at(coords.v1) : nil
        )
    }
}

func intersections(_ straight: Saber, _ rect: CGRect) -> TwoOptionalSpotResult {
    return intersectionCoordinates(straight.arrow, rect).map {
        coords in
        return Two<Spot?>(
            v0: straight.kind.covers(coords.v0) ? straight.arrow.at(coords.v0) : nil,
            v1: straight.kind.covers(coords.v1) ? straight.arrow.at(coords.v1) : nil
        )
    }
}

func intersections(_ c0: Ring, _ c1: Ring) -> TwoSpotResult {
    let arrow = Arrow(points: (c0.center, c1.center))
    let d = arrow.vector.norm
    return (1 ~/ d).flatMap {
        dRec in
        let r0Sq = c0.radius * c0.radius
        let r1Sq = c1.radius * c1.radius
        let d0 = (d - (r1Sq - r0Sq) * dRec) / 2
        return sqrt(Result.success(r0Sq - d0 * d0)).map {
            h in
            let b = arrow.at(d0 * dRec)
            let hv = arrow.vector.orthogonal * (dRec * h)
            return Two(v0: b - hv, v1: b + hv)
        }
    }
}

func intersections(_ straight: SaberResult, _ circle: RingResult) -> TwoOptionalSpotResult {
    return straight.flatMap { s in circle.flatMap { c in intersections(s,c) } }
}

func intersections(_ c0: RingResult, _ c1: RingResult) -> TwoSpotResult {
    return c0.flatMap { c0 in c1.flatMap { c1 in intersections(c0, c1) } }
}

// MARK: Protocol extensions

private extension TwoByTwoProtocol where T: FloatProtocol {
    var inverse: Result<TwoByTwo<T>, MathError> {
        return TwoByTwo(a00: a11, a01: -a01, a10: -a10, a11: a00) / determinant
    }
}

extension Result where T: RingProtocol, Error: MathErrorProtocol {
    init(cicumscribing points: (Spot, Spot, Spot)) {
        let d = 2 * ( points.0.x * (points.1.y - points.2.y)
            + points.1.x * (points.2.y - points.0.y)
            + points.2.x * (points.0.y - points.1.y)
        )
        let u = 2 * ( points.0.squaredNorm * (points.1 - points.2)
            + points.1.squaredNorm * (points.2 - points.0)
            + points.2.squaredNorm * (points.0 - points.1)
        )
        self = (Spot(x: u.y, y: -u.x) / d)
            .map {
                center in
                let radius = distance(center, points.0)
                return T(center: center, radius: radius)
            }
            .mapError { Error($0) }
    }
    
    init (cicumscribing points: (SpotResult, SpotResult, SpotResult)) {
        self = points.0.flatMap { p0 in return points.1.flatMap{ p1 in return points.2.flatMap { p2 in return Result(cicumscribing: (p0, p1, p2)) } } }
    }
}
