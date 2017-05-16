//
//  FreeScalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class FreeScalar: Figure, Scalar, FreeValued {
    var storage = FigureStorage<Float>()
    var _position: Float
    
    init(at initial: Float, `in` context: FigureContext) {
        _position = initial
        context.append(self)
    }
    
    func nearestPosition(from point: RawPoint) -> Result<CGFloat, MathError> {
        return .none
    }
}
