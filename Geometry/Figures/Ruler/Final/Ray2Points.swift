//
//  Ray2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Ray2Points: Figure, Ruler2Points, Ray {
    var ruler2PointsStorage: Ruler2PointsStorage
    init(_ s: Ruler2PointsStorage) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.sorted
    
    func at(_ pos: CGFloat) -> RawPointResult {
        return result.flatMap {
            value in
            normReciprocal.map {
                normReciprocal in
                value.arrow.at(max(pos,0) * normReciprocal)
            }
        }
    }
    
    func nearest(from point: RawPoint) -> FloatResult {
        return result.arrow.projectIso(point).map { max($0, 0) }
    }
}
