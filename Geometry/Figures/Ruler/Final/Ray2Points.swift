//
//  Ray2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class Ray2Points<R: RawRulerProtocol>: Ray, Ruler2PointsStandard {
    var ruler2PointsStorage: Ruler2PointsStorage<R>
    init(_ s: Ruler2PointsStorage<R>) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.sorted
}
