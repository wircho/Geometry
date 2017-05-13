//
//  StraightCircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

class StraightCircleMediator: Figure<Two<Spot?>> {
    weak var straight: Straight?
    weak var circle: Circle?
    
    init(_ straight: Straight, _ circle: Circle) {
        self.straight = straight
        self.circle = circle
        super.init(sorted: [straight, circle])
    }
    
    override func recalculate() -> TwoOptionalSpotResult {
        return intersections(straight.coalescedValue, circle.coalescedValue)
    }
    
    override func drawIn(_ rect: CGRect) {
        // Do nothing
    }
}

// MARK: - Intersection Point

class StraightCircleIntersection: Point {
    enum Index {
        case first
        case second
    }
    
    weak var mediator: StraightCircleMediator?
    var index: Index
    
    init(_ mediator: StraightCircleMediator, _ index: Index) {
        self.mediator = mediator
        self.index = index
        super.init(mediator)
    }
    
    static func create(_ straight: Straight, _ circle: Circle) -> (mediator: StraightCircleMediator, point0: StraightCircleIntersection, point1: StraightCircleIntersection) {
        let mediator = StraightCircleMediator(straight, circle)
        return (
            mediator: mediator,
            point0: StraightCircleIntersection(mediator, .first),
            point1: StraightCircleIntersection(mediator, .second)
        )
    }
    
    override func recalculate() -> SpotResult {
        switch index {
        case .first: return mediator?.result.v0.optional ?? .none
        case .second: return mediator?.result.v1.optional ?? .none
        }
    }
}
