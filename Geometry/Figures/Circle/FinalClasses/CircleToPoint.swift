//
//  CircleToPoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class CircleToPoint: Circle {
    weak var center: Point?
    weak var point: Point?
    
    init(center: Point, point: Point) {
        self.center = center
        self.point = point
        super.init(sorted: [center, point])
    }
    
    override func recalculate() -> RingResult {
        return RingResult(center: center.coalescedValue, point: point.coalescedValue)
    }
}
