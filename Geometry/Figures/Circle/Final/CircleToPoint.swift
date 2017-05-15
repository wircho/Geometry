//
//  CircleToPoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleToPoint: Figure, Circle, ParentComparable {
    var circleStorage = CircleStorage()
    
    weak var center: Point?
    weak var point: Point?
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [center, point] }
    
    init(_ center: Point, _ point: Point) {
        self.center = center
        self.point = point
        setChildOf([center, point])
    }
    
    var touchingDefiningPoints: [Point] {
        return [point].flatMap { $0 }
    }
    
    func recalculate() -> RawCircleResult {
        return RawCircleResult(center: center?.result ?? .none, point: point?.result ?? .none)
    }
}
