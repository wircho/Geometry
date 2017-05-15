//
//  CircleWithRadius.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleWithRadius: Figure, Circle, ParentComparable {
    var appearance = Appearance()
    var storage = FigureStorage<RawCircle>()
    var circleStorage = CircleStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var center: Point?
    weak var radius: Scalar?
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [center, radius] }
    
    init(_ center: Point, _ radius: Scalar) {
        self.center = center
        self.radius = radius
        appendToContext()
    }
    
    var touchingDefiningPoints: [Point] {
        return []
    }
    
    func recalculate() -> RawCircleResult {
        return RawCircleResult(center: center?.result ?? .none, radius: radius?.result ?? .none)
    }
}
