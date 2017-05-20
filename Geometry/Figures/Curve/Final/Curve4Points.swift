//
//  Curve4Points.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Curve4Points: Figure, Curve {
    var curveStorage = CurveStorage()
    
    weak var point0: Point?
    weak var point1: Point?
    weak var point2: Point?
    weak var point3: Point?
    
    init(_ point0: Point, _ point1: Point, _ point2: Point, _ point3: Point) {
        self.point0 = point0
        self.point1 = point1
        self.point2 = point2
        self.point3 = point3
        setChildOf([point0, point1, point2, point3])
    }
    
    func compare(with other: Curve4Points) -> Bool {
        return (point0 === other.point0 && point1 === other.point1 && point2 === other.point2 && point3 === other.point3)
            || (point0 === other.point3 && point1 === other.point2 && point2 === other.point1 && point3 === other.point0)
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point3].flatMap { $0 }
    }
    
    func recalculate() -> Res<RawCurve> {
        return Res<RawCurve>(point0: point0?.result ?? .none, control0: point1?.result ?? .none, control1: point2?.result ?? .none, point1: point3?.result ?? .none)
    }
}
