//
//  Baricenter.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Baricenter<P: RawPointProtocol>: Point, ParentComparable {
    var pointStorage = PointStorage<P>()
    
    let points: [AnyWeakFigure<P>]
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return points.map { $0.figure } }
    
    init?(points: [AnyFigure<P>]) {
        guard points.count >= 2 else { return nil }
        self.points = points.map { $0.anyWeakFigure }
        setChildOf(points.map { $0.figure })
    }
    
    func recalculate() -> Res<P> {
        var sum = Res<P>.success(.zero)
        for any in points {
            guard let point = any.result else { continue }
            sum += point
        }
        return sum / Res<P.Value>.success(P.Value(points.count))
    }
}
