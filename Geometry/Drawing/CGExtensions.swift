//
//  CGExtensions.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import UIKit

extension CGRect {
    init(circle: RawCircle) {
        let side = 2 * circle.radius
        self.init(x: circle.center.x - circle.radius, y: circle.center.y - circle.radius, width: side, height: side)
    }
}

extension UIBezierPath {
    convenience init(circle: RawCircle, lineWidth: CGFloat = 1) {
        self.init(ovalIn: CGRect(circle: circle))
        self.lineWidth = lineWidth
    }
    
    convenience init(segment point0: CGPoint, _ point1: CGPoint, lineWidth: CGFloat = 1) {
        self.init()
        self.move(to: point0)
        self.addLine(to: point1)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
    
    convenience init(arc: RawArc, lineWidth: CGFloat = 1) {
        self.init()
        let angleValues = arc.angleValues
        self.addArc(withCenter: arc.circle.center, radius: arc.circle.radius, startAngle: angleValues.v0, endAngle: angleValues.v1, clockwise: true)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
}
