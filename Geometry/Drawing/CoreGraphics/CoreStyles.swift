//
//  CoreStyles.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-20.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

struct CorePointStyle: PointStyle, SelectableFigureStyle {
    var diameter: CGFloat
    var color: UIColor
    
    static var `default`: CorePointStyle {
        return CorePointStyle(diameter: 6, color: .black)
    }
    
    var selected: CorePointStyle {
        return CorePointStyle(diameter: diameter, color: .selection)
    }
}

struct CoreStrokeStyle: StrokeStyle, SelectableFigureStyle {
    var lineWidth: CGFloat
    var color: UIColor
    
    static var `default`: CoreStrokeStyle {
        return CoreStrokeStyle(lineWidth: 5, color: .black)
    }
    
    var selected: CoreStrokeStyle {
        return CoreStrokeStyle(lineWidth: lineWidth, color: .selection)
    }
}
