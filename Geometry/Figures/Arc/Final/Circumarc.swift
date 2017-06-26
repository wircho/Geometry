//
//  Circumarc.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class Circumarc<A: RawArcProtocol>: Arc, Bounded, ParentComparable {
    typealias FigureValue = A
    var arcStorage = ArcStorage<A>()
    
    var point0: AnyWeakFigure<A.Circle.Point>
    var point1: AnyWeakFigure<A.Circle.Point>
    var point2: AnyWeakFigure<A.Circle.Point>
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [point0.figure, point1.figure, point2.figure] }
    
    init<P0: Point, P1: Point, P2: Point>(_ p0: P0, _ p1: P1, _ p2: P2) where P0.ResultValue == Res<A.Circle.Point>, P1.ResultValue == Res<A.Circle.Point>, P2.ResultValue == Res<A.Circle.Point> {
        point1 = AnyWeakFigure(p1)
        if (p0.cedula.value < p2.cedula.value) {
            point0 = AnyWeakFigure(p0)
            point2 = AnyWeakFigure(p2)
        } else {
            point0 = AnyWeakFigure(p2)
            point2 = AnyWeakFigure(p0)
        }
        setChildOf([p0, p1, p2])
    }
    
    var touchingDefiningPoints: [AnyFigure<A.Circle.Point>] {
        return [point0, point1, point2].flatMap { $0.anyFigure }
    }
    
    func update() -> Res<A> {
        return Res(cicumscribing: (point0.result ?? .none, point1.result ?? .none, point2.result ?? .none))
    }
    
    var startingPoint: AnyWeakFigure<A.Circle.Point> { return point0 }
    var endingPoint: AnyWeakFigure<A.Circle.Point> { return point1 }
}
