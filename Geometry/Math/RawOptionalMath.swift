//
//  RawOptionalMath.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-02.
//  Copyright © 2017 Trovy. All rights reserved.
//

//import Result
import Darwin

// MARK: Operator declarations

infix operator /? : MultiplicationPrecedence
infix operator *? : MultiplicationPrecedence
infix operator •? : MultiplicationPrecedence
infix operator +? : AdditionPrecedence
infix operator -? : AdditionPrecedence

// MARK: Values

func +?<Value: RawValueProtocol>(lhs: Value?, rhs: @autoclosure () -> Value?) -> Value? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs + rhs
}

func -?<Value: RawValueProtocol>(lhs: Value?, rhs: @autoclosure () -> Value?) -> Value? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs - rhs
}

func *?<Value: RawValueProtocol>(lhs: Value?, rhs: @autoclosure () -> Value?) -> Value? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs * rhs
}

func /?<Value: RawValueProtocol>(lhs: Value?, rhs: @autoclosure () -> Value?) -> Value? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    let value = lhs / rhs
    return value.isInfinite ? nil : value
}

// MARK: Points

func +?<Point: RawPointProtocol>(lhs: Point?, rhs: @autoclosure () -> Point?) -> Point? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs + rhs
}

func -?<Point: RawPointProtocol>(lhs: Point?, rhs: @autoclosure () -> Point?) -> Point? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs - rhs
}

func *?<Point: RawPointProtocol>(lhs: Point.Value?, rhs: @autoclosure () -> Point?) -> Point? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs * rhs
}

func *?<Point: RawPointProtocol>(lhs: Point?, rhs: @autoclosure () -> Point.Value?) -> Point? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs * rhs
}

func /?<Point: RawPointProtocol>(lhs: Point?, rhs: @autoclosure () -> Point.Value?) -> Point? {
    return Point(x: lhs?.x /? rhs, y: lhs?.y /? rhs)
}

func •?<Point: RawPointProtocol>(lhs: Point?, rhs: @autoclosure () -> Point?) -> Point.Value? {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs • rhs
}

// MARK: Two

func •?<Two: TwoProtocol>(lhs: Two?, rhs: @autoclosure () -> Two?) -> Two.T? where Two.T: RawValueProtocol {
    guard let lhs = lhs, let rhs = rhs() else { return nil }
    return lhs • rhs
}

// MARK: Two by two

func /?<TwoByTwo: TwoByTwoProtocol>(lhs: TwoByTwo, rhs: TwoByTwo.T) -> TwoByTwo? where TwoByTwo.T: RawValueProtocol {
    return TwoByTwo(a00: lhs.a00 /? rhs, a01: lhs.a01 /? rhs, a10: lhs.a10 /? rhs, a11: lhs.a11 /? rhs)
}

extension TwoByTwoProtocol where T: RawValueProtocol {
    var inverse: Self? {
        return Self(a00: a11, a01: -a01, a10: -a10, a11: a00) /? determinant
    }
}

// MARK: Arrow

extension ArrowProtocol {
    func reflect(_ rawPoint: Point?) -> Point? {
        guard let rawPoint = rawPoint, let p = project(rawPoint) else { return nil }
        return 2 * at(offset: p) - rawPoint
    }
    
    func project(_ rawPoint: Point?) -> Point.Value? {
        guard let rawPoint = rawPoint, let nRec2 = 1 /? vector.squaredNorm else { return nil }
        return (vector • (rawPoint - points.0)) * nRec2
    }
    
    func projectIso(_ rawPoint: Point?) -> Point.Value? {
        guard let rawPoint = rawPoint, let nRec = 1 /? vector.norm else { return nil }
        return (vector • (rawPoint - points.0)) * nRec
    }
}

// MARK: Circle

extension RawCircleProtocol {
    init?(cicumscribing point0: Point?, _ point1: @autoclosure () -> Point?, _ point2: @autoclosure () -> Point?) {
        guard let point0 = point0, let point1 = point1(), let point2 = point2() else { return nil }
        let d0 = point0.x * (point1.y - point2.y)
        let d1 = point1.x * (point2.y - point0.y)
        let d2 = point2.x * (point0.y - point1.y)
        let d = 2 * (d0 + d1 + d2)
        guard let dInv = 1 /? d else { return nil }
        let u0 = point0.squaredNorm * (point1 - point2)
        let u1 = point1.squaredNorm * (point2 - point0)
        let u2 = point2.squaredNorm * (point0 - point1)
        let u = u0 + u1 + u2
        let center = Point(x: u.y, y: -u.x) * dInv
        self.init(center: center, radius: distance(center, point0))
    }
}

extension RawArcProtocol {
    init?(cicumscribing point0: Circle.Point?, _ point1: @autoclosure () -> Circle.Point?, _ point2: @autoclosure () -> Circle.Point?) {
        guard let point0 = point0, let point1 = point1(), let point2 = point2() else { return nil }
        let d0 = point0.x * (point1.y - point2.y)
        let d1 = point1.x * (point2.y - point0.y)
        let d2 = point2.x * (point0.y - point1.y)
        let d = 2 * (d0 + d1 + d2)
        guard let dInv = 1 /? d else { return nil }
        let u0 = point0.squaredNorm * (point1 - point2)
        let u1 = point1.squaredNorm * (point2 - point0)
        let u2 = point2.squaredNorm * (point0 - point1)
        let u = u0 + u1 + u2
        let center = Circle.Point(x: u.y, y: -u.x) * dInv
        let radius = distance(center, point0)
        let circle = Circle(center: center, radius: radius)
        let angles = ((point0 - center).angle, (point1 - center).angle, (point2 - center).angle)
        let angle0 = TwoAngles.T(value: angles.0.value)
        let angle2 = TwoAngles.T(value: angles.0.value)
        let m = angles.0.greaterValue(angles.1) < angles.0.greaterValue(angles.2)
        self.init(circle: circle, angles: m ? TwoAngles(v0: angle0, v1: angle2) : TwoAngles(v0: angle2, v1: angle0), fromFirst: m)
    }
}

// MARK Not NaN

extension RawValueProtocol {
    var notNaN: Self? { return isNaN ? nil : self }
}

// MARK: Global functions

func squareDistance<Point: RawPointProtocol>(_ point0: Point?, _ point1: Point?) -> Point.Value? {
    return (point0 -? point1)?.squaredNorm
}

func distance<Point: RawPointProtocol>(_ point0: Point?, _ point1: Point?) -> Point.Value? {
    return (point0 -? point1)?.norm
}

// MARK: Intersections of two arrows/rulers

func intersectionCoordinates<Arrow: ArrowProtocol>(_ arrow0: Arrow, _ arrow1: Arrow) -> Two<Arrow.Point.Value>? {
    guard let inv = (arrow0.vector | -arrow1.vector).inverse else { return nil }
    return inv * (arrow1.points.0 - arrow0.points.0).coordinates
}

func intersection<Ruler: RawRulerProtocol>(_ ruler0: Ruler?, _ ruler1: @autoclosure () -> Ruler?) -> Ruler.Arrow.Point? {
    guard let ruler0 = ruler0, let ruler1 = ruler1() else { return nil }
    guard let coords = intersectionCoordinates(ruler0.arrow, ruler1.arrow) else { return nil }
    guard ruler0.kind.covers(coords.v0) && ruler1.kind.covers(coords.v1) else { return nil }
    return ruler0.arrow.at(offset: coords.v0)
}

// MARK: Arrow/circle intersection

func intersectionCoordinates<Arrow: ArrowProtocol, Circle: RawCircleProtocol>(_ arrow: Arrow, _ circle: Circle) -> Two<Arrow.Point.Value>? where Arrow.Point == Circle.Point {
    guard let nRec = 1 /? arrow.vector.norm else { return nil }
    let c = (circle.center - arrow.points.0) • arrow.vector * nRec
    let pc = arrow.at(offset: c * nRec)
    let dc = distance(pc, circle.center)
    guard dc <= circle.radius else { return nil }
    let e = sqrt(circle.radius * circle.radius - dc * dc)
    return Two(v0: (c - e) * nRec, v1: (c + e) * nRec)
    
}

func intersections<Ruler: RawRulerProtocol, Circle: RawCircleProtocol>(_ ruler: Ruler?, _ circle: @autoclosure () -> Circle?) -> Two<Ruler.Arrow.Point?>? where Ruler.Arrow.Point == Circle.Point {
    guard let ruler = ruler, let circle = circle() else { return nil }
    guard let coords = intersectionCoordinates(ruler.arrow, circle) else { return nil }
    let v0: Ruler.Arrow.Point? = ruler.kind.covers(coords.v0) ? ruler.arrow.at(offset: coords.v0) : nil
    let v1: Ruler.Arrow.Point? = ruler.kind.covers(coords.v1) ? ruler.arrow.at(offset: coords.v1) : nil
    return Two<Ruler.Arrow.Point?>(v0: v0, v1: v1)
}

// MARK: Arrow/rect intersection

func intersectionCoordinates<Arrow: ArrowProtocol, Rect: RawRectProtocol>(_ arrow: Arrow, _ rect: Rect) -> Two<Arrow.Point.Value>? where Arrow.Point == Rect.Point {
    let vector = arrow.vector
    let minX = rect.minX
    let minY = rect.minY
    let maxX = rect.maxX
    let maxY = rect.maxY
    guard let minXC = (minX - arrow.points.0.x) /? vector.x, let maxXC = (maxX - arrow.points.0.x) /? vector.x else {
        guard arrow.points.0.x > minX && arrow.points.0.x < maxX else { return nil }
        guard let minYC = (minY - arrow.points.0.y) /? vector.y, let maxYC = (maxY - arrow.points.0.y) /? vector.y else { return nil }
        return Two(v0: min(minYC, maxYC), v1: max(minYC, maxYC))
    }
    guard let minYC = (minY - arrow.points.0.y) /? vector.y, let maxYC = (maxY - arrow.points.0.y) /? vector.y else {
        guard arrow.points.0.y > minY && arrow.points.0.y < maxY else { return nil }
        return Two(v0: min(minXC, maxXC), v1: max(minXC, maxXC))
    }
    let x0 = min(minXC, maxXC)
    let x1 = max(minXC, maxXC)
    let y0 = min(minYC, maxYC)
    let y1 = max(minYC, maxYC)
    guard x1 > y0 && y1 > x0 else { return nil }
    return Two(v0: max(x0, y0), v1: min(x1, y1))
}

func intersections<Ruler: RawRulerProtocol, Rect: RawRectProtocol>(_ ruler: Ruler?, _ rect: @autoclosure () -> Rect?) -> Two<Ruler.Arrow.Point?>? where Ruler.Arrow.Point == Rect.Point {
    guard let ruler = ruler, let rect = rect() else { return nil }
    guard let coords = intersectionCoordinates(ruler.arrow, rect) else { return nil }
    let v0 = ruler.kind.covers(coords.v0) ? ruler.arrow.at(offset: coords.v0) : nil
    let v1 = ruler.kind.covers(coords.v1) ? ruler.arrow.at(offset: coords.v1) : nil
    return Two<Ruler.Arrow.Point?>(v0: v0, v1: v1)
}

// MARK: Intersections between two circles

func intersections<Circle: RawCircleProtocol>(_ c0: Circle?, _ c1: @autoclosure () -> Circle?) -> Two<Circle.Point>? {
    guard let c0 = c0, let c1 = c1() else { return nil }
    let arrow = Arrow(points: (c0.center, c1.center))
    let d = arrow.vector.norm
    guard let dRec = 1 /? d else { return nil }
    let r0Sq = c0.radius * c0.radius
    let r1Sq = c1.radius * c1.radius
    let d0 = (d - (r1Sq - r0Sq) * dRec) / 2
    guard let h = (r0Sq - d0 * d0).squareRoot().notNaN else { return nil }
    let b = arrow.at(offset: d0 * dRec)
    let hv = arrow.vector.orthogonal * (dRec * h)
    return Two(v0: b - hv, v1: b + hv)
}
