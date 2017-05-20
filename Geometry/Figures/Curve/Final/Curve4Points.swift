//
//  Curve4Points.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Curve4Points: Figure, Curve, Bounded {
    var curveStorage = CurveStorage()
    
    weak var point0: Point?
    weak var control0: Point?
    weak var control1: Point?
    weak var point1: Point?
    
    init(_ point0: Point, _ control0: Point, _ control1: Point, _ point1: Point) {
        self.point0 = point0
        self.control0 = control0
        self.control1 = control1
        self.point1 = point1
        setChildOf([point0, control0, control1, point1])
    }
    
    func compare(with other: Curve4Points) -> Bool {
        return (point0 === other.point0 && control0 === other.control0 && control1 === other.control1 && point1 === other.point1)
            || (point0 === other.point1 && control0 === other.control1 && control1 === other.control0 && point1 === other.point0)
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1].flatMap { $0 }
    }
    
    func recalculate() -> Res<RawCurve> {
        return Res(point0: point0?.result ?? .none, control0: control0?.result ?? .none, control1: control1?.result ?? .none, point1: point1?.result ?? .none)
    }
    
    var startingPoint: Point? { return point0 }
    var endingPoint: Point? { return point1 }
}
