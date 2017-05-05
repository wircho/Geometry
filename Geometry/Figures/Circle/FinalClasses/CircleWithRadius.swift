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
    var center: Getter<RCGPoint>
    var radius: Getter<RCGFloat>
    
    init(center: Point, radius: Scalar) {
        self.center = center.getter
        self.radius = radius.getter
        super.init(center, radius)
    }
    
    override func getRaw() -> Result<CGCircle, CGError> {
        return RCGCircle(center: center.value, radius: radius.value)
    }
}
