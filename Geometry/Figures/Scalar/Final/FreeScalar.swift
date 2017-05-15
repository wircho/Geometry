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
    
    init(at initial: Float) {
        _position = initial
        appendToContext()
    }
}
