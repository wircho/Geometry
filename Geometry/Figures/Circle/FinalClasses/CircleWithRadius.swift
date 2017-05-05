//
//  CircleWithRadius.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class CircleWithRadius: Circle {
    weak var center: Point?
    weak var radius: Scalar?
    
    init(center: Point, radius: Scalar) {
        self.center = center
        self.radius = radius
        super.init(sorted: [center, radius])
    }
    
    override func getRaw() -> Result<CGCircle, CGError> {
        return RCGCircle(center: center.defaultedRaw, radius: radius.defaultedRaw)
    }
}
