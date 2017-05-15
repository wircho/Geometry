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
    func distanceFrom(point: RawPoint) -> FloatResult
    var touchRadius: Float { get }
    var touchPriority: Int { get }
}
