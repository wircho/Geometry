//
//  Segment2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Segment2Points<R: RawRulerProtocol>: Segment, Ruler2PointsStandard, Bounded {
    var ruler2PointsStorage: Ruler2PointsStorage<R>
    init(_ s: Ruler2PointsStorage<R>) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.unsorted
    
    func at(offset: R.Arrow.Point.Value) -> Res<R.Arrow.Point> {
        return result.map { $0.arrow.at(offset: min(max(offset,0),1)) }
    }
    
    func nearestOffset(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.arrow.project(point).map { min(max($0, 0), 1) }
    }
    
    var startingPoint: AnyWeakFigure<R.Arrow.Point> { return point0 }
    var endingPoint: AnyWeakFigure<R.Arrow.Point> { return point1 }
}
