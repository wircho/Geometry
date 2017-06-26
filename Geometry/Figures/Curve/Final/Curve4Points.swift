//
//  Curve4Points.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class Curve4Points<C: RawCurveProtocol>: Curve, Bounded {
    typealias FigureValue = C
    var curveStorage = CurveStorage<C>()
    
    var point0: AnyWeakFigure<C.Point>
    var control0: AnyWeakFigure<C.Point>
    var control1: AnyWeakFigure<C.Point>
    var point1: AnyWeakFigure<C.Point>
    
    init<P0: Point, C0: Point, C1: Point, P1: Point>(_ p0: P0, _ c0: C0, _ c1: C1, _ p1: P1) where P0.ResultValue == Res<C.Point>, C0.ResultValue == Res<C.Point>, C1.ResultValue == Res<C.Point>, P1.ResultValue == Res<C.Point> {
        self.point0 = AnyWeakFigure(p0)
        self.control0 = AnyWeakFigure(c0)
        self.control1 = AnyWeakFigure(c1)
        self.point1 = AnyWeakFigure(p1)
        setChildOf([p0, c0, c1, p1])
    }
    
    func compare(with other: Curve4Points) -> Bool {
        return (point0 == other.point0 && control0 == other.control0 && control1 == other.control1 && point1 == other.point1)
            || (point0 == other.point1 && control0 == other.control1 && control1 == other.control0 && point1 == other.point0)
    }
    
    var touchingDefiningPoints: [AnyFigure<C.Point>] {
        return [point0, point1].flatMap { $0.anyFigure }
    }
    
    func update() -> Res<C> {
        return Res(point0: point0.result ?? .none, control0: control0.result ?? .none, control1: control1.result ?? .none, point1: point1.result ?? .none)
    }
    
    var startingPoint: AnyWeakFigure<C.Point> { return point0 }
    var endingPoint: AnyWeakFigure<C.Point> { return point1 }
}
