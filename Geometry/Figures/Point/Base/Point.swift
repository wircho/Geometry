//
//  Point.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Point: FigureBase, Appears, Drawable {
    var result: SpotResult { get }
}

extension Point {
    var radius: Float {
        get {
            return lineWidth / 2
        }
        set {
            lineWidth = newValue * 2
        }
    }
    
    func drawIn(_ rect: CGRect) {
        guard let center = result.value else { return }
        color.setFill()
        UIBezierPath(circleWithCenter: center, radius: radius).fill()
    }
}

// TODO: - Circumcenter, Baricenter, Point On object
// TODO: (Long term) Point In object
