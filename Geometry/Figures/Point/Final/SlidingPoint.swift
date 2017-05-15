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
    var pointStorage = PointStorage()
    var _position: Float
    
    weak var floor: OneDimensional?
    
    init(_ floor: OneDimensional, at initial: Float) {
        self.floor = floor
        _position = initial
        floor.slidingPoints.append(self)
        setChildOf([floor])
    }
    
    func recalculate() -> RawPointResult {
        return floor?.at(position) ?? .none
    }
}
