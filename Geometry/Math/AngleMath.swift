//
//  AngleMath.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

extension Angle {
    init (vector: RawPoint) {
        value = atan2(vector.y, vector.x)
    }
    
    func vector(radius: CGFloat) -> RawPoint {
        return CGPoint(x: radius * cos(value), y: radius * sin(value))
    }
}
