//
//  SlidingPoint.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class SlidingPoint: Figure, Point {
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<Spot>()
    var _position: Float
    
    weak var floor: OneDimensional?
    
    var position: Float {
        get { return _position }
        set {
            _position = newValue
            needsRecalculation = true
        }
    }
    
    init(_ floor: OneDimensional, at initial: Float) {
        self.floor = floor
        _position = initial
        floor.slidingPoints.append(self)
        appendToContext()
    }
    
    func recalculate() -> SpotResult {
        return Result(value: floor?.at(position)).optional ?? .none
    }
}
