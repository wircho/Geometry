//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class Circle: Figure<Ring>, OneDimensional {
    
    var lineWidth: CGFloat = 2
    var color: UIColor = .black
    let cedula = Cedula()
    
    override func drawIn(_ rect: CGRect) {
        guard let ring = result.value else { return }
        color.setStroke()
        UIBezierPath(circleWithCenter: ring.center, radius: ring.radius, lineWidth: lineWidth).stroke()
    }
    
    func at(_ pos: Float) -> Spot? {
        guard let radius = result.value?.radius else { return nil }
        return Angle(value: pos).vector(radius: radius)
    }
}
