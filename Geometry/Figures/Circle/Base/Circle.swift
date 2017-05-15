//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Circle: FigureBase, OneDimensional, StrokeAppears, Drawable {
    var result: RawCircleResult { get }
    var circleStorage: CircleStorage { get set }
}

extension Circle {
    func drawIn(_ rect: CGRect) {
        guard let value = result.value else { return }
        color.setStroke()
        UIBezierPath(circle: value, lineWidth: lineWidth).stroke()
    }
    
    func at(_ pos: Float) -> RawPoint? {
        guard let circle = result.value else { return nil }
        return  circle.center + Angle(value: pos).vector(radius: circle.radius)
    }
    
    var cedula: Cedula {
        return circleStorage.cedula
    }
    
    var appearance: StrokeAppearance {
        get { return circleStorage.appearance }
        set { circleStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawCircle> {
        get { return circleStorage.figureStorage }
        set { circleStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage {
        get { return circleStorage.oneDimensionalStorage }
        set { circleStorage.oneDimensionalStorage = newValue }
    }
}

struct CircleStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawCircle>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
