//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class FreePoint: Figure, Point, FreeValue {
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<Spot>()
    var _position: Spot
    
    init(at initial: Spot) {
        _position = initial
        appendToContext()
    }
    
    convenience init(x: Float, y: Float) {
        self.init(at: Spot(x: x, y: y))
    }
}
