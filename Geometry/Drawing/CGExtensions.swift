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
    init(center: CGPoint, radius: CGFloat) {
        let side = 2 * radius
        self.init(x: center.x - radius, y: center.y - radius, width: side, height: side)
    }
}

extension UIBezierPath {
    convenience init(circleWithCenter center: CGPoint, radius: CGFloat, lineWidth: CGFloat = 1) {
        self.init(ovalIn: CGRect(center: center, radius: radius))
        self.lineWidth = lineWidth
    }
    
    convenience init(segment point0: CGPoint, _ point1: CGPoint, lineWidth: CGFloat = 1) {
        self.init()
        self.move(to: point0)
        self.addLine(to: point1)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
}
