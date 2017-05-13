//
//  TwoCircles.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

class TwoCircleMediator: Figure<Two<Spot>> {
    var circles: (Weak<Circle>, Weak<Circle>)
    
    init(_ c0: Circle, _ c1: Circle) {
        if (c0.cedula.value < c1.cedula.value) {
            circles = (Weak(c0), Weak(c1))
        } else {
            circles = (Weak(c1), Weak(c0))
        }
        super.init(unsorted: [c0, c1])
    }
    
    override func recalculate() -> TwoSpotResult {
        return intersections(circles.0.coalescedValue, circles.1.coalescedValue)
    }
    
    override func drawIn(_ rect: CGRect) {
        // Do nothing
    }
}

// MARK: - Intersection Point

class TwoCircleIntersection: Point {
    enum Index {
        case first
        case second
    }
    
    weak var mediator: TwoCircleMediator?
    var index: Index
    
    init(_ mediator: TwoCircleMediator, _ index: Index) {
        self.mediator = mediator
        self.index = index
        super.init(mediator)
    }
    
    static func create(_ c0: Circle, _ c1: Circle) -> (mediator: TwoCircleMediator, point0: TwoCircleIntersection, point1: TwoCircleIntersection) {
        let mediator = TwoCircleMediator(c0, c1)
        return (
            mediator: mediator,
            point0: TwoCircleIntersection(mediator, .first),
            point1: TwoCircleIntersection(mediator, .second)
        )
    }
    
    override func recalculate() -> SpotResult {
        switch index {
        case .first: return mediator?.result.v0 ?? .none
        case .second: return mediator?.result.v1 ?? .none
        }
    }
}
