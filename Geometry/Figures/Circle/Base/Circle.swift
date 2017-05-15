//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Circle: FigureBase, OneDimensional, StrokeAppears, Drawable, Touchable {
    var result: RawCircleResult { get }
    var circleStorage: CircleStorage { get set }
}

extension Circle {
    func drawIn(_ rect: CGRect) {
        guard let value = result.value else { return }
        color.setStroke()
        UIBezierPath(circle: value, lineWidth: lineWidth).stroke()
    }
    
    func at(_ pos: Float) -> RawPointResult {
        return result.map {
            circle in
            return  circle.center + Angle(value: pos).vector(radius: circle.radius)
        }
    }
    
    func closest(from point: RawPoint) -> FloatResult {
        return result.map {
            circle in
            return (point - circle.center).angle.value
        }
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
    
    func distanceFrom(point: RawPoint) -> FloatResult {
        return result.map {
            circle in
            return abs(circle.radius - distance(point, circle.center))
        }
    }
    
    var touchRadius: Float { return 40 }
    
    var touchPriority: Int { return 901 }
}

struct CircleStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawCircle>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
