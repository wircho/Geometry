//
//  ReflectionPoint.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-08.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class ReflectionPoint<P: RawPointProtocol>: Point, ParentComparable {
    var pointStorage = PointStorage<P>()
    
    let point: AnyWeakFigure<P>
    let center: AnyWeakFigure<P>
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [point.figure, center.figure] }
    
    init<PT: Point, CT: Point>(_ point: PT, _ center: CT) where PT.ResultValue == Res<P>, CT.ResultValue == Res<P> {
        self.point = AnyWeakFigure(point)
        self.center = AnyWeakFigure(center)
        setChildOf([point, center])
    }
    
    func recalculate() -> Res<P> {
        guard let p = point.result, let c = center.result else { return .none }
        return c + (c - p)
    }
}

