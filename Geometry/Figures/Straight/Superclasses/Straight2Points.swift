//
//  Straight2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Figures Through 2 Points

class Straight2Points: Straight {
    var points: (Weak<Point>, Weak<Point>)
    
    init(_ p0: Point, _ p1: Point, sorted: Bool) {
        self.points = Weak.tuple(p0, p1)
        super.init(unsorted: [p0, p1])
    }
    
    var arrow: RCGArrow {
        return RCGArrow(points: (points.0.coalescedValue, points.1.coalescedValue))
    }
}

class Straight2PointsSorted: Straight2Points {
    init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: true) }
}

class Straight2PointsUnsorted: Straight2Points {
    init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: false) }
}
