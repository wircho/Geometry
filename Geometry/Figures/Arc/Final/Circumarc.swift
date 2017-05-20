//
//  Circumarc.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Circumarc: Figure, Arc, Bounded, ParentComparable {
    var arcStorage = ArcStorage()
    
    weak var point0: Point?
    weak var point1: Point?
    weak var point2: Point?
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [point0, point1, point2] }
    
    init(_ pt0: Point, _ pt1: Point, _ pt2: Point) {
        let (p0, p1, p2) = (pt0.cedula.value < pt2.cedula.value) ? (pt0, pt1, pt2) : (pt2, pt1, pt0)
        point0 = p0
        point1 = p1
        point2 = p2
        setChildOf([p0, p1, p2])
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1, point2].flatMap { $0 }
    }
    
    func recalculate() -> Res<RawArc> {
        return Res<RawArc>(cicumscribing: (point0?.result ?? .none, point1?.result ?? .none, point2?.result ?? .none))
    }
    
    var startingPoint: Point? { return point0 }
    var endingPoint: Point? { return point1 }
}
