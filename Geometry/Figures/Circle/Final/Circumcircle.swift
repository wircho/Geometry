//
//  Circumcircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Circumcircle: Figure, Circle, ParentComparable {
    var appearance = StrokeAppearance()
    var storage = FigureStorage<RawCircle>()
    var circleStorage = CircleStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var point0: Point?
    weak var point1: Point?
    weak var point2: Point?
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return [point0, point1, point2] }
    
    init(_ p0: Point, _ p1: Point, _ p2: Point) {
        point0 = p0
        point1 = p1
        point2 = p2
        appendToContext()
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1, point2].flatMap { $0 }
    }
    
    func recalculate() -> RawCircleResult {
        return RawCircleResult(cicumscribing: (point0?.result ?? .none, point1?.result ?? .none, point2?.result ?? .none))
    }
}
