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
    
    var touchingPoints: [Point] {
        return [points.0, points.1].flatMap { $0.object }
    }
    
    func calculateArrow() -> ArrowResult {
        return ArrowResult(points: (points.0.coalescedValue, points.1.coalescedValue))
    }
    
    override func at(_ pos: Float) -> Spot? {
        guard let value = result.value, let normReciprocal = normReciprocal else { return nil }
        switch value.kind {
        case .line: return value.arrow.at(pos)
        case .segment: return value.arrow.at(min(max(pos,0),1))
        case .ray: return value.arrow.at(max(pos,0) * normReciprocal)
        }
    }
}

protocol Straight2PointsWithSorting {
    init(_ p0: Point, _ p1: Point)
}

class Straight2PointsSorted: Straight2Points, Straight2PointsWithSorting {
    required init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: true) }
}

class Straight2PointsUnsorted: Straight2Points, Straight2PointsWithSorting {
    required init(_ p0: Point, _ p1: Point) { super.init(p0, p1, sorted: false) }
}
