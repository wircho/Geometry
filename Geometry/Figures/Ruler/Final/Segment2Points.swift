//
//  Segment2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Segment2Points: Figure, Ruler2Points, Segment {
    var ruler2PointsStorage: Ruler2PointsStorage
    init(_ s: Ruler2PointsStorage) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.unsorted
    
    func at(_ pos: CGFloat) -> RawPointResult {
        return result.map { $0.arrow.at(min(max(pos,0),1)) }
    }
    
    func nearest(from point: RawPoint) -> FloatResult {
        return result.arrow.project(point).map { min(max($0, 0), 1) }
    }
}
