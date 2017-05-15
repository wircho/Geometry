//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class FreePoint: Figure, Point, FreeValued {
    var pointStorage = PointStorage()
    var _position: RawPoint
    
    init(at initial: RawPoint, `in` context: FigureContext) {
        _position = initial
        context.append(self)
    }
    
    convenience init(x: Float, y: Float, `in` context: FigureContext) {
        self.init(at: RawPoint(x: x, y: y), in: context)
    }
}
