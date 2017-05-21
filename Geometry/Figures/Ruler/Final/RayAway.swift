//
//  RayAway.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class RayAway: Figure, Ruler2Points, Ray {
    var ruler2PointsStorage: Ruler2PointsStorage
    init(_ s: Ruler2PointsStorage) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.sorted
    
    func calculateArrow() -> Res<Arrow> {
        let p0 = point0?.result ?? .none
        let p1 = point1?.result ?? .none
        return Res<Arrow>(points: (p1, 2 * p1 - p0))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point1].flatMap { $0 }
    }
}
