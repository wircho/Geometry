//
//  Circumcircle.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class Circumcircle: Circle {
    var points: (Getter<RCGPoint>, Getter<RCGPoint>, Getter<RCGPoint>)
    
    init(_ p0: Point, _ p1: Point, _ p2: Point) {
        self.points = (p0.getter, p1.getter, p2.getter)
        super.init(unsorted: p0, p1, p2)
    }
    
    override func getRaw() -> RCGCircle {
        return RCGCircle(cicumscribing: (points.0.value, points.1.value, points.2.value))
    }
}
