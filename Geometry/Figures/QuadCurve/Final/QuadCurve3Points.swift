//
//  QuadCurve2Points.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class QuadCurve3Points<C: RawQuadCurveProtocol>: QuadCurve, Bounded {
    typealias FigureValue = C
    var quadCurveStorage = QuadCurveStorage<C>()
    
    var point0: AnyWeakFigure<C.Point>
    var control: AnyWeakFigure<C.Point>
    var point1: AnyWeakFigure<C.Point>
    
    init<P0: Point, Ctrl: Point, P1: Point>(_ p0: P0, _ c: Ctrl, _ p1: P1) where P0.ResultValue == Res<C.Point>, Ctrl.ResultValue == Res<C.Point>, P1.ResultValue == Res<C.Point> {
        self.point0 = AnyWeakFigure(p0)
        self.control = AnyWeakFigure(c)
        self.point1 = AnyWeakFigure(p1)
        setChildOf([p0, c, p1])
    }
    
    func compare(with other: QuadCurve3Points) -> Bool {
        return (point0 == other.point0 && control == other.control && point1 == other.point1)
            || (point0 == other.point1 && control == other.control && point1 == other.point0)
    }
    
    var touchingDefiningPoints: [AnyFigure<C.Point>] {
        return [point0, point1].flatMap { $0.anyFigure }
    }
    
    func recalculate() -> Res<C> {
        return Res(point0: point0.result ?? .none, control: control.result ?? .none, point1: point1.result ?? .none)
    }
    
    var startingPoint: AnyWeakFigure<C.Point> { return point0 }
    var endingPoint: AnyWeakFigure<C.Point>  { return point1 }
}
