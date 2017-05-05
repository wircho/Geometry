//
//  Straight2Points.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Figures Through 2 Points

class Straight2Points: Straight {
    var points: (Getter<RCGPoint>, Getter<RCGPoint>)
    
    init(_ p0: Point, _ p1: Point, sorted: Bool) {
        self.points = (p0.getter, p1.getter)
        super.init(unsorted: p0, p1)
    }
    
    var arrow: RCGArrow {
        return RCGArrow(points: (points.0.value, points.1.value))
    }
}

class Straight2PointsSorted: Straight2Points {
    init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: true) }
}

class Straight2PointsUnsorted: Straight2Points {
    init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: false) }
}
