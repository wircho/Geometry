//
//  Circumcircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class Circumcircle: Circle {
    var points: (Weak<Point>, Weak<Point>, Weak<Point>)
    
    init(_ p0: Point, _ p1: Point, _ p2: Point) {
        self.points = Weak.tuple(p0, p1, p2)
        super.init(unsorted: [p0, p1, p2])
    }
    
    override func recalculate() -> RCGCircle {
        return RCGCircle(cicumscribing: (points.0.coalescedValue, points.1.coalescedValue, points.2.coalescedValue))
    }
}
