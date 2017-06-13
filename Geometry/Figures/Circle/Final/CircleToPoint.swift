//
//  CircleToPoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleToPoint<C: RawCircleProtocol>: Circle, ParentComparable {
    typealias FigureValue = C
    var circleStorage = CircleStorage<C>()
    
    var center: AnyWeakFigure<C.Point>
    var point: AnyWeakFigure<C.Point>
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [center.figure, point.figure] }
    
    init<P0: Point, P1: Point>(_ center: P0, _ point: P1) where P0.ResultValue == Res<C.Point>, P1.ResultValue == Res<C.Point> {
        self.center = AnyWeakFigure(center)
        self.point = AnyWeakFigure(point)
        setChildOf([center, point])
    }
    
    var touchingDefiningPoints: [AnyFigure<C.Point>] {
        return [point].flatMap { $0.anyFigure }
    }
    
    func update() -> Res<C> {
        return Res(center: center.result ?? .none, point: point.result ?? .none)
    }
}
