//
//  CircleToPoint.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class CircleToPoint: Circle {
    var center: Getter<RCGPoint>
    var point: Getter<RCGPoint>
    
    init(center: Point, point: Point) {
        self.center = center.getter
        self.point = point.getter
        super.init(center, point)
    }
    
    override func getRaw() -> Result<CGCircle, CGError> {
        return RCGCircle(center: center.value, point: point.value)
    }
}
