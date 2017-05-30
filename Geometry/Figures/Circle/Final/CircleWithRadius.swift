//
//  CircleWithRadius.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleWithRadius<C: RawCircleProtocol>: Circle, ParentComparable {
    typealias FigureValue = C
    var circleStorage = CircleStorage<C>()
    
    var center: AnyWeakFigure<C.Point>
    var radius: AnyWeakFigure<C.Point.Value>
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [center.figure, radius.figure] }
    
    init<P: Point, S: Scalar>(_ center: P, _ radius: S) where P.ResultValue == Res<C.Point>, S.ResultValue == Res<C.Point.Value> {
        self.center = AnyWeakFigure(center)
        self.radius = AnyWeakFigure(radius)
        setChildOf([center, radius])
    }
    
    var touchingDefiningPoints: [AnyFigure<C.Point>] {
        return []
    }
    
    func recalculate() -> Res<C> {
        return Res(center: center.result ?? .none, radius: radius.result ?? .none)
    }
}
