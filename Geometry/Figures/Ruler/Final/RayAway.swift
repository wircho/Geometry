//
//  RayAway.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class RayAway<R: RawRulerProtocol>: Ray, Ruler2Points {
    var ruler2PointsStorage: Ruler2PointsStorage<R>
    init(_ s: Ruler2PointsStorage<R>) { ruler2PointsStorage = s }
    
    let parentOrder = ParentOrder.sorted
    
    func calculateArrow() -> Res<R.Arrow> {
        let p0 = point0.result ?? .none
        let p1 = point1.result ?? .none
        return Res(points: (p1, 2 * p1 - p0))
    }
    
    var touchingDefiningPoints: [AnyFigure<R.Arrow.Point>] {
        return [point1].flatMap { $0.anyFigure }
    }
}
