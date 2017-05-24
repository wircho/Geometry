//
//  _ResultMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-02.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result


// MARKL: Operations

func ~/<Value: RawValueProtocol>(lhs: Value, rhs: Value) -> Res<Value> {
    let value = lhs / rhs
    return value.isInfinite ? .infinity : .success(value)
}

func +<Value: RawValueProtocol>(lhs: Res<Value>, rhs: Res<Value>) -> Res<Value> {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs + rhs } }
}

func -<Value: RawValueProtocol>(lhs: Res<Value>, rhs: Res<Value>) -> Res<Value> {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs - rhs } }
}

func *<Value: RawValueProtocol>(lhs: Res<Value>, rhs: Res<Value>) -> Res<Value> {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs * rhs } }
}

func *<Value: RawValueProtocol>(lhs: Value, rhs: Res<Value>) -> Res<Value> {
    return rhs.map { rhs in return lhs * rhs }
}

func /<Value: RawValueProtocol>(lhs: Res<Value>, rhs: Res<Value>) -> Res<Value> {
    return lhs.flatMap { lhs in return rhs.flatMap { rhs in return lhs ~/ rhs } }
}

prefix func -<Value: RawValueProtocol>(value: Res<Value>) -> Res<Value> {
    return value.map { -$0 }
}

func +<Point: RawPointProtocol>(lhs: Res<Point>, rhs: Res<Point>) -> Res<Point> {
    return Res<Point>(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func +=<Point: RawPointProtocol>(lhs: inout Res<Point>, rhs: Res<Point>) {
    lhs = lhs + rhs
}

func -<Point: RawPointProtocol>(lhs: Res<Point>, rhs: Res<Point>) -> Res<Point> {
    return Res<Point>(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func -=<Point: RawPointProtocol>(lhs: inout Res<Point>, rhs: Res<Point>) {
    lhs = lhs - rhs
}

prefix func -<Point: RawPointProtocol>(point: Res<Point>) -> Res<Point> {
    return Res<Point>(x: -point.x, y: -point.y)
}

func *<Point: RawPointProtocol>(lhs: Point.Value, rhs: Res<Point>) -> Res<Point> {
    return Res<Point>(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *<Point: RawPointProtocol>(lhs: Res<Point.Value>, rhs: Res<Point>) -> Res<Point> {
    return Res<Point>(x: lhs * rhs.x, y: lhs * rhs.y)
}

func *<Point: RawPointProtocol>(lhs: Res<Point>, rhs: Res<Point.Value>) -> Res<Point> {
    return Res<Point>(x: rhs * lhs.x, y: rhs * lhs.y)
}

func /<Point: RawPointProtocol>(lhs: Point, rhs: Point.Value) -> Res<Point> {
    return (lhs.x ~/ rhs).flatMap { x in (lhs.y ~/ rhs).map { y in Point(x: x, y: y) } }
}

func /<Point: RawPointProtocol>(lhs: Res<Point>, rhs: Res<Point.Value>) -> Res<Point> {
    return Res<Point>(x: lhs.x / rhs, y: lhs.y / rhs)
}

func •<Point: RawPointProtocol>(lhs: Res<Point>, rhs: Res<Point>) -> Res<Point.Value> {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

func •<Value: RawValueProtocol>(lhs: Res<Two<Value>>, rhs: Res<Two<Value>>) -> Res<Value> {
    return lhs.flatMap { lhs in return rhs.map { rhs in return lhs • rhs } }
}

func /<Value: RawValueProtocol>(lhs: TwoByTwo<Value>, rhs: Value) -> Result<TwoByTwo<Value>, MathError> {
    return (lhs.a00 ~/ rhs).flatMap { a00 in (lhs.a01 ~/ rhs).flatMap { a01 in (lhs.a10 ~/ rhs).flatMap { a10 in (lhs.a11 ~/ rhs).map { a11 in TwoByTwo(a00: a00, a01: a01, a10: a10, a11: a11) } } } }
}

// MARK: Protocol extensions

private extension TwoByTwoProtocol where T: RawValueProtocol {
    var inverse: Res<TwoByTwo<T>> {
        return TwoByTwo(a00: a11, a01: -a01, a10: -a10, a11: a00) / determinant
    }
}

extension ArrowProtocol {
    func reflect(_ rawPoint: Point) -> Res<Point> {
        return project(rawPoint).map {
            p in
            return 2 * at(offset: p) - rawPoint
        }
    }
    
    func project(_ rawPoint: Point) -> Res<Point.Value> {
        let nRec2 = 1 ~/ vector.squaredNorm
        return nRec2.map {
            nRec2 in
            return (vector • (rawPoint - points.0)) * nRec2
        }
    }
    
    func projectIso(_ rawPoint: Point) -> Res<Point.Value> {
        let nRec = 1 ~/ vector.norm
        return nRec.map {
            nRec in
            return (vector • (rawPoint - points.0)) * nRec
        }
    }
}

extension Result where T: ArrowProtocol, Error: MathErrorProtocol {
    func reflect(_ rawPoint: T.Point) -> Res<T.Point> {
        return flatMap { $0.reflect(rawPoint).mapError { Error($0) } }
    }
    
    func reflect(_ rawPoint: Res<T.Point>) -> Res<T.Point> {
        return rawPoint.flatMap { reflect($0) }
    }
    
    func project(_ rawPoint: T.Point) -> Res<T.Point.Value> {
        return flatMap { $0.project(rawPoint).mapError { Error($0) } }
    }
    
    func project(_ rawPoint: Res<T.Point>) -> Res<T.Point.Value> {
        return rawPoint.flatMap { project($0) }
    }
    
    func projectIso(_ rawPoint: T.Point) -> Res<T.Point.Value> {
        return flatMap { $0.projectIso(rawPoint).mapError { Error($0) } }
    }
    
    func projectIso(_ rawPoint: Res<T.Point>) -> Res<T.Point.Value> {
        return rawPoint.flatMap { projectIso($0) }
    }
    
    func at(offset: Res<T.Point.Value>) -> Res<T.Point> {
        return flatMap { s in offset.map { offset in s.at(offset: offset) } }
    }
}

extension Result where T: RawCircleProtocol, Error: MathErrorProtocol {
    init(cicumscribing points: (T.Point, T.Point, T.Point)) {
        let d0 = points.0.x * (points.1.y - points.2.y)
        let d1 = points.1.x * (points.2.y - points.0.y)
        let d2 = points.2.x * (points.0.y - points.1.y)
        let d = 2 * (d0 + d1 + d2)
        let u0 = points.0.squaredNorm * (points.1 - points.2)
        let u1 = points.1.squaredNorm * (points.2 - points.0)
        let u2 = points.2.squaredNorm * (points.0 - points.1)
        let u = u0 + u1 + u2
        let center = T.Point(x: u.y, y: -u.x) / d
        self = center.map { T(center: $0, radius: distance($0, points.0)) }.mapError { Error($0) }
    }
    
    init (cicumscribing points: (Res<T.Point>, Res<T.Point>, Res<T.Point>)) {
        self = points.0.flatMap { p0 in return points.1.flatMap{ p1 in return points.2.flatMap { p2 in return Result(cicumscribing: (p0, p1, p2)) } } }
    }
}

extension Result where T: RawArcProtocol, Error: MathErrorProtocol {
    init(cicumscribing points: (T.Circle.Point, T.Circle.Point, T.Circle.Point)) {
        let d0 = points.0.x * (points.1.y - points.2.y)
        let d1 = points.1.x * (points.2.y - points.0.y)
        let d2 = points.2.x * (points.0.y - points.1.y)
        let d = 2 * (d0 + d1 + d2)
        let u0 = points.0.squaredNorm * (points.1 - points.2)
        let u1 = points.1.squaredNorm * (points.2 - points.0)
        let u2 = points.2.squaredNorm * (points.0 - points.1)
        let u = u0 + u1 + u2
        let center = T.Circle.Point(x: u.y, y: -u.x) / d
        self = center
            .map {
                center in
                let radius = distance(center, points.0)
                let circle = T.Circle(center: center, radius: radius)
                let angles = ((points.0 - center).angle, (points.1 - center).angle, (points.2 - center).angle)
                if angles.0.greaterValue(angles.1) < angles.0.greaterValue(angles.2) {
                    return T(circle: circle, angles: Two(v0: angles.0, v1: angles.2), fromFirst: true)
                } else {
                    return T(circle: circle, angles: Two(v0: angles.2, v1: angles.0), fromFirst: false)
                }
            }
            .mapError { Error($0) }
    }
    
    init (cicumscribing points: (Res<T.Circle.Point>, Res<T.Circle.Point>, Res<T.Circle.Point>)) {
        self = points.0.flatMap { p0 in return points.1.flatMap{ p1 in return points.2.flatMap { p2 in return Result(cicumscribing: (p0, p1, p2)) } } }
    }
}

// MARK: Global functions

func squareDistance<Point: RawPointProtocol>(_ point0: Res<Point>, _ point1: Res<Point>) -> Res<Point.Value> {
    return (point0 - point1).squaredNorm
}

func distance<Point: RawPointProtocol>(_ point0: Res<Point>, _ point1: Res<Point>) -> Res<Point.Value> {
    return (point0 - point1).norm
}

func sqrt<Value: RawValueProtocol>(_ value: Res<Value>) -> Res<Value> {
    return value.flatMap {
        value in
        let s = sqrt(value)
        guard !s.isNaN else {
            return .complex
        }
        return .success(s)
    }
}

func intersectionCoordinates<Arrow: ArrowProtocol>(_ arrow0: Arrow, _ arrow1: Arrow) -> Res<Two<Arrow.Point.Value>> {
    return (arrow0.vector | -arrow1.vector).inverse.map { $0 * (arrow1.points.0 - arrow0.points.0).coordinates }
}


func intersection<Ruler: RawRulerProtocol>(_ ruler0: Ruler, _ ruler1: Ruler) -> Res<Ruler.Arrow.Point> {
    return intersectionCoordinates(ruler0.arrow, ruler1.arrow).flatMap {
        coords in
        guard ruler0.kind.covers(coords.v0) && ruler1.kind.covers(coords.v1) else {
            return .none
        }
        return .success(ruler0.arrow.at(offset: coords.v0))
    }
}

func intersection<Ruler: RawRulerProtocol>(_ ruler0: Res<Ruler>, _ ruler1: Res<Ruler>) -> Res<Ruler.Arrow.Point> {
    return ruler0.flatMap { s0 in return ruler1.flatMap { s1 in return intersection(s0, s1) } }
}

func intersectionCoordinates<Arrow: ArrowProtocol, Circle: RawCircleProtocol>(_ arrow: Arrow, _ circle: Circle) -> Res<Two<Arrow.Point.Value>> where Arrow.Point == Circle.Point {
    return (1 ~/ arrow.vector.norm).flatMap {
        nRec in
        let c = (circle.center - arrow.points.0) • arrow.vector * nRec
        let pc = arrow.at(offset: c * nRec)
        let dc = distance(pc, circle.center)
        guard dc <= circle.radius else {
            return .none
        }
        let e = sqrt(circle.radius * circle.radius - dc * dc)
        return .success(Two(v0: (c - e) * nRec, v1: (c + e) * nRec))
    }
    
}

func intersectionCoordinates<Arrow: ArrowProtocol, Rect: RawRectProtocol>(_ arrow: Arrow, _ rect: Rect) -> Res<Two<Arrow.Point.Value>> where Arrow.Point == Rect.Point {
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

func intersections<Ruler: RawRulerProtocol, Circle: RawCircleProtocol>(_ ruler: Ruler, _ circle: Circle) -> Res<Two<Ruler.Arrow.Point?>> where Ruler.Arrow.Point == Circle.Point {
    return intersectionCoordinates(ruler.arrow, circle).map {
        coords in
        let v0: Ruler.Arrow.Point? = ruler.kind.covers(coords.v0) ? ruler.arrow.at(offset: coords.v0) : nil
        let v1: Ruler.Arrow.Point? = ruler.kind.covers(coords.v1) ? ruler.arrow.at(offset: coords.v1) : nil
        return Two<Ruler.Arrow.Point?>(
            v0: v0,
            v1: v1
        )
    }
}

func intersections<Ruler: RawRulerProtocol, Rect: RawRectProtocol>(_ ruler: Ruler, _ rect: Rect) -> Res<Two<Ruler.Arrow.Point?>> where Ruler.Arrow.Point == Rect.Point {
    return intersectionCoordinates(ruler.arrow, rect).map {
        coords in
        return Two<Ruler.Arrow.Point?>(
            v0: ruler.kind.covers(coords.v0) ? ruler.arrow.at(offset: coords.v0) : nil,
            v1: ruler.kind.covers(coords.v1) ? ruler.arrow.at(offset: coords.v1) : nil
        )
    }
}

func intersections<Circle: RawCircleProtocol>(_ c0: Circle, _ c1: Circle) -> Res<Two<Circle.Point>> {
    let arrow = Arrow(points: (c0.center, c1.center))
    let d = arrow.vector.norm
    return (1 ~/ d).flatMap {
        dRec in
        let r0Sq = c0.radius * c0.radius
        let r1Sq = c1.radius * c1.radius
        let d0 = (d - (r1Sq - r0Sq) * dRec) / 2
        return sqrt(Result.success(r0Sq - d0 * d0)).map {
            h in
            let b = arrow.at(offset: d0 * dRec)
            let hv = arrow.vector.orthogonal * (dRec * h)
            return Two(v0: b - hv, v1: b + hv)
        }
    }
}

func intersections<Ruler: RawRulerProtocol, Circle: RawCircleProtocol>(_ ruler: Res<Ruler>, _ circle: Res<Circle>) -> Res<Two<Ruler.Arrow.Point?>> where Ruler.Arrow.Point == Circle.Point {
    return ruler.flatMap { s in circle.flatMap { c in intersections(s,c) } }
}

func intersections<Circle: RawCircleProtocol>(_ c0: Res<Circle>, _ c1: Res<Circle>) -> Res<Two<Circle.Point>> {
    return c0.flatMap { c0 in c1.flatMap { c1 in intersections(c0, c1) } }
}

