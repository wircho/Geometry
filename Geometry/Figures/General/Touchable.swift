//
//  Touchable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result


protocol Touchable: FigureBase {
    func gap(from point: RawPoint) -> FloatResult
    var touchPriority: Float { get }
}
