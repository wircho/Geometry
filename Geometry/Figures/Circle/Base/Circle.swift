//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Circle: FigureBase, OneDimensional, Appears, Drawable {
    var result: RingResult { get }
    var circleStorage: CircleStorage { get set }
}

extension Circle {
    func drawIn(_ rect: CGRect) {
        guard let ring = result.value else { return }
        color.setStroke()
        UIBezierPath(circleWithCenter: ring.center, radius: ring.radius, lineWidth: lineWidth).stroke()
    }
    
    func at(_ pos: Float) -> Spot? {
        guard let radius = result.value?.radius else { return nil }
        return Angle(value: pos).vector(radius: radius)
    }
    
    var cedula: Cedula {
        return circleStorage.cedula
    }
}

struct CircleStorage {
    let cedula = Cedula()
}
