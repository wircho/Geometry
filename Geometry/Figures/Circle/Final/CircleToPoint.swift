//
//  CircleToPoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleToPoint: Figure, Circle {
    var appearance = Appearance()
    var storage = FigureStorage<Ring>()
    var circleStorage = CircleStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var center: Point?
    weak var point: Point?
    
    init(_ center: Point, _ point: Point) {
        self.center = center
        self.point = point
        appendToContext()
    }
    
    var touchingDefiningPoints: [Point] {
        return [point].flatMap { $0 }
    }
    
    func recalculate() -> RingResult {
        return RingResult(center: center?.result ?? .none, point: point?.result ?? .none)
    }
}
