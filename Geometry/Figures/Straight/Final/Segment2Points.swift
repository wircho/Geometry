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
    
    func at(_ pos: Float) -> RawPoint? {
        return result.value?.arrow.at(min(max(pos,0),1))
    }
}

