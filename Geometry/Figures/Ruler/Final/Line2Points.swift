//
//  Line2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Line2Points<R: RawRulerProtocol>: Line, Ruler2PointsStandard {
    var ruler2PointsStorage: Ruler2PointsStorage<R>
    init(_ s: Ruler2PointsStorage<R>) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.unsorted
    
    func at(offset: R.Arrow.Point.Value) -> Res<R.Arrow.Point> {
        return result.map { $0.arrow.at(offset: offset) }
    }
    
    func nearestOffset(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.arrow.project(point)
    }
}
