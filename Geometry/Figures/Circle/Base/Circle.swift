//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Circle: FigureBase, OneDimensional, StrokeAppears, Touchable {
    var result: Res<RawCircle> { get }
    var circleStorage: CircleStorage { get set }
}

extension Circle {
    func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(circle: value, lineWidth: appearance.lineWidth).stroke()
    }
    
    func at(_ pos: CGFloat) -> Res<RawPoint> {
        return result.map {
            circle in
            return  circle.center + Angle(value: pos).vector(radius: circle.radius)
        }
    }
    
    func nearest(from point: RawPoint) -> Res<CGFloat> {
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
    
    func gapToCenter(from point: RawPoint) -> Res<CGFloat> {
        return result.map {
            circle in
            return abs(circle.radius - distance(point, circle.center))
        }
    }
    
    var touchPriority: CGFloat { return 600 }
}

struct CircleStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawCircle>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
