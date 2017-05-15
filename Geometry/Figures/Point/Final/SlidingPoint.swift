//
//  SlidingPoint.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class SlidingPoint: Figure, Point, FreeValued {
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<RawPoint>()
    var _position: Float
    
    weak var floor: OneDimensional?
    
    init(_ floor: OneDimensional, at initial: Float) {
        self.floor = floor
        _position = initial
        floor.slidingPoints.append(self)
        appendToContext()
    }
    
    func recalculate() -> RawPointResult {
        return Result(value: floor?.at(position)).optional ?? .none
    }
}
