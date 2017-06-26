//
//  Circumcircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class Circumcircle<C: RawCircleProtocol>: Circle, ParentComparable {
    typealias FigureValue = C
    var circleStorage = CircleStorage<C>()
    
    var point0: AnyWeakFigure<C.Point>
    var point1: AnyWeakFigure<C.Point>
    var point2: AnyWeakFigure<C.Point>
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return [point0.figure, point1.figure, point2.figure] }
    
    init<P0: Point, P1: Point, P2: Point>(_ p0: P0, _ p1: P1, _ p2: P2) where P0.ResultValue == Res<C.Point>,  P1.ResultValue == Res<C.Point>,  P2.ResultValue == Res<C.Point> {
        point0 = AnyWeakFigure(p0)
        point1 = AnyWeakFigure(p1)
        point2 = AnyWeakFigure(p2)
        setChildOf([p0, p1, p2])
    }
    
    var touchingDefiningPoints: [AnyFigure<C.Point>] {
        return [point0, point1, point2].flatMap { $0.anyFigure }
    }
    
    func update() -> Res<C> {
        return Res(cicumscribing: (point0.result ?? .none, point1.result ?? .none, point2.result ?? .none))
    }
}
