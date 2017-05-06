//
//  CGResultMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-02.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result


// MARKL: Operations

func ~/(lhs: CGFloat, rhs: CGFloat) -> RCGFloat {
    let value = lhs / rhs
    return value.isInfinite ? .failure(CGError.infinity) : .success(value)
}

func +(lhs: RCGFloat, rhs: RCGFloat) -> RCGFloat {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs + rhs } }
}

func -(lhs: RCGFloat, rhs: RCGFloat) -> RCGFloat {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs - rhs } }
}

func *(lhs: RCGFloat, rhs: RCGFloat) -> RCGFloat {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs * rhs } }
}

func /(lhs: RCGFloat, rhs: RCGFloat) -> RCGFloat {
    return lhs.flatMap { lhs in return rhs.flatMap { rhs in return lhs ~/ rhs } }
}

prefix func -(value: RCGFloat) -> RCGFloat {
    return value.map { -$0 }
}

func +(lhs: RCGPoint, rhs: RCGPoint) -> RCGPoint {
    return RCGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: RCGPoint, rhs: RCGPoint) -> RCGPoint {
    return RCGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

prefix func -(point: RCGPoint) -> RCGPoint {
    return RCGPoint(x: -point.x, y: -point.y)
}

func *(lhs: RCGFloat, rhs: RCGPoint) -> RCGPoint {
    return RCGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *(lhs: RCGPoint, rhs: RCGFloat) -> RCGPoint {
    return RCGPoint(x: rhs * lhs.x, y: rhs * lhs.y)
}

func /(lhs: CGPoint, rhs: CGFloat) -> RCGPoint {
    return (lhs.x ~/ rhs).flatMap { x in (lhs.y ~/ rhs).map { y in CGPoint(x: x, y: y) } }
}

func /(lhs: RCGPoint, rhs: RCGFloat) -> RCGPoint {
    return RCGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

func •(lhs: RCGPoint, rhs: RCGPoint) -> RCGFloat {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •(lhs: RCG2, rhs: RCG2) -> RCGFloat {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs • rhs } }
}

func /(lhs: CG2x2, rhs: CGFloat) -> RCG2x2 {
    return (lhs.a00 ~/ rhs).flatMap { a00 in (lhs.a01 ~/ rhs).flatMap { a01 in (lhs.a10 ~/ rhs).flatMap { a10 in (lhs.a11 ~/ rhs).map { a11 in CG2x2(a00: a00, a01: a01, a10: a10, a11: a11) } } } }
}

// MARK: Global functions

func squareDistance(_ point0: RCGPoint, _ point1: RCGPoint) -> RCGFloat {
    return (point0 - point1).squaredNorm
}

func distance(_ point0: RCGPoint, _ point1: RCGPoint) -> RCGFloat {
    return (point0 - point1).norm
}

func sqrt(_ value: RCGFloat) -> RCGFloat {
    return value.flatMap {
        value in
        guard value >= 0 else {
            return .failure(CGError.complex)
        }
        return .success(sqrt(value))
    }
}

func intersectionCoordinates(_ arrow0: CGArrow, _ arrow1: CGArrow) -> RCG2 {
    //(01 - 00) * alpha - (11 - 10) * beta =  10 - 00
    return (arrow0.at0 | -arrow1.at0).inverse.map { $0  * (arrow1.points.0 - arrow0.points.0).coordinates }
}

func intersection(_ arrow0: CGArrow, _ arrow1: CGArrow) -> RCGPoint {
    return intersectionCoordinates(arrow0, arrow1).map { arrow0.points.0 + arrow0.at0 * $0.0 }
}

func intersection(_ straight0: CGStraight, _ straight1: CGStraight) -> RCGPoint {
    return intersectionCoordinates(straight0.arrow, straight1.arrow).flatMap {
        coords in
        guard straight0.kind.covers(coords.0) && straight1.kind.covers(coords.1) else {
            return .none
        }
        return .success(straight0.arrow.at(coords.0))
    }
}

func intersection(_ straight0: RCGStraight, _ straight1: RCGStraight) -> RCGPoint {
    return straight0.flatMap { s0 in return straight1.flatMap { s1 in return intersection(s0, s1) } }
}

func intersectionCoordinates(_ arrow: CGArrow, _ circle: CGCircle) -> RCG2 {
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

func intersections(_ straight: CGStraight, _ circle: CGCircle) -> RCGPoint2 {
    return intersectionCoordinates(straight.arrow, circle).map {
        coords in
        return CGPoint2(
            first: straight.kind.covers(coords.0) ? straight.arrow.at(coords.0) : nil,
            second: straight.kind.covers(coords.1) ? straight.arrow.at(coords.1) : nil
        )
    }
}

func intersections(_ straight: RCGStraight, _ circle: RCGCircle) -> RCGPoint2 {
    return straight.flatMap { s in circle.flatMap { c in intersections(s,c) } }
}

// MARK: Protocol extensions

private extension CG2x2Protocol {
    var inverse: RCG2x2 {
        return CG2x2(a00: a11, a01: -a01, a10: -a10, a11: a00) / determinant
    }
}

extension Result where T: CGCircleProtocol, Error: CGErrorProtocol {
    init(cicumscribing points: (CGPoint, CGPoint, CGPoint)) {
        let d = 2 * ( points.0.x * (points.1.y - points.2.y)
            + points.1.x * (points.2.y - points.0.y)
            + points.2.x * (points.0.y - points.1.y)
        )
        let u = 2 * ( points.0.squaredNorm * (points.1 - points.2)
            + points.1.squaredNorm * (points.2 - points.0)
            + points.2.squaredNorm * (points.0 - points.1)
        )
        self = (CGPoint(x: u.y, y: -u.x) / d)
            .map {
                center in
                let radius = distance(center, points.0)
                return T(center: center, radius: radius)
            }
            .mapError { Error($0) }
    }
    
    init (cicumscribing points: (RCGPoint, RCGPoint, RCGPoint)) {
        self = points.0.flatMap { p0 in return points.1.flatMap{ p1 in return points.2.flatMap { p2 in return Result(cicumscribing: (p0, p1, p2)) } } }
    }
}
