//
//  QuadCurve2Points.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class QuadCurve3Points: Figure, QuadCurve, Bounded {
    var quadCurveStorage = QuadCurveStorage()
    
    weak var point0: Point?
    weak var control: Point?
    weak var point1: Point?
    
    init(_ point0: Point, _ control: Point, _ point1: Point) {
        self.point0 = point0
        self.control = control
        self.point1 = point1
        setChildOf([point0, control, point1])
    }
    
    func compare(with other: QuadCurve3Points) -> Bool {
        return (point0 === other.point0 && control === other.control && point1 === other.point1)
            || (point0 === other.point1 && control === other.control && point1 === other.point0)
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1].flatMap { $0 }
    }
    
    func recalculate() -> Res<RawQuadCurve> {
        return Res(point0: point0?.result ?? .none, control: control?.result ?? .none, point1: point1?.result ?? .none)
    }
    
    var startingPoint: Point? { return point0 }
    var endingPoint: Point? { return point1 }
}
