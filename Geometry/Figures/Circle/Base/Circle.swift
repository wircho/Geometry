//
//  Circle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Circle: OneDimensional /*, StrokeAppears, Touchable*/ {
    associatedtype C: RawCircleProtocol
    var result: Res<C> { get }
    var circleStorage: CircleStorage<C> { get set }
}

extension Circle {
    /*func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(circle: value, lineWidth: appearance.lineWidth).stroke()
    }*/
    
    func at(offset: C.Point.Value) -> Res<C.Point> {
        return result.map {
            circle in
            return  circle.center + Angle(value: offset).vector(radius: circle.radius)
        }
    }
    
    func nearestOffset(from point: C.Point) -> Res<C.Point.Value> {
        return result.map {
            circle in
            return (point - circle.center).angle.value
        }
    }
    
    var cedula: Cedula {
        return circleStorage.cedula
    }
   /*
    var appearance: StrokeAppearance {
        get { return circleStorage.appearance }
        set { circleStorage.appearance = newValue }
    }
    */
    
    var storage: FigureStorage<C> {
        get { return circleStorage.figureStorage }
        set { circleStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage<C.Point> {
        get { return circleStorage.oneDimensionalStorage }
        set { circleStorage.oneDimensionalStorage = newValue }
    }
    
    func gap(from point: C.Point) -> Res<C.Point.Value> {
        return result.map {
            circle in
            return abs(circle.radius - distance(point, circle.center))
        }
    }
    
    var touchPriority: CGFloat { return 600 }
}

struct CircleStorage<C: RawCircleProtocol> {
    let cedula = Cedula()
    /* var appearance = StrokeAppearance() */
    var figureStorage = FigureStorage<C>()
    var oneDimensionalStorage = OneDimensionalStorage<C.Point>()
}
