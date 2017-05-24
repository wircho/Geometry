//
//  CoupleOfPoints.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct OnePoint<P: RawPointProtocol> {
    var point: AnyWeakFigure<P>
    init<T: Point>(_ point: T) where T.ResultValue == Res<P> {
        self.point = AnyWeakFigure(point)
    }
}

struct TwoPoints<P: RawPointProtocol> {
    var point0: AnyWeakFigure<P>
    var point1: AnyWeakFigure<P>
    init<T0: Point, T1: Point>(_ point0: T0, _ point1: T1) where T0.ResultValue == Res<P>, T1.ResultValue == Res<P> {
        self.point0 = AnyWeakFigure(point0)
        self.point1 = AnyWeakFigure(point1)
    }
    init<T1: Point>(_ point0: OnePoint<P>, _ point1: T1) where T1.ResultValue == Res<P> {
        self.point0 = point0.point
        self.point1 = AnyWeakFigure(point1)
    }
}

enum CoupleOfPoints<P: RawPointProtocol> {
    case none
    case one(OnePoint<P>)
    case two(TwoPoints<P>)
    
    mutating func add<T: Point>(_ point: T) -> Bool where T.ResultValue == Res<P> {
        switch self {
        case .none:
            self = .one(OnePoint(point))
            return true
        case let .one(pt):
            self = .two(TwoPoints(pt, point))
            fallthrough
        case .two:
            return false
        }
    }
}
