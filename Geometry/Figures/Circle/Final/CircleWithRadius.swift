//
//  CircleWithRadius.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class CircleWithRadius: Figure, Circle {
    var appearance = Appearance()
    var storage = FigureStorage<Ring>()
    var circleStorage = CircleStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var center: Point?
    weak var radius: Scalar?
    
    init(_ center: Point, _ radius: Scalar) {
        self.center = center
        self.radius = radius
        appendToContext()
    }
    
    var touchingDefiningPoints: [Point] {
        return []
    }
    
    func recalculate() -> RingResult {
        return RingResult(center: center?.result ?? .none, radius: radius?.result ?? .none)
    }
}
