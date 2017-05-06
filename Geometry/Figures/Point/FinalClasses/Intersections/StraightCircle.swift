//
//  StraightCircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

class StraightCircleMediator: Figure<CGPoint2> {
    weak var straight: Straight?
    weak var circle: Circle?
    
    init(straight: Straight, circle: Circle) {
        self.straight = straight
        self.circle = circle
        super.init(sorted: [straight, circle])
    }
    
    override func recalculate() -> RCGPoint2 {
        return intersections(straight.coalescedValue, circle.coalescedValue)
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
    
    init(mediator: StraightCircleMediator, index: Index) {
        self.mediator = mediator
        self.index = index
        super.init(mediator)
    }
    
    override func recalculate() -> Result<CGPoint, CGError> {
        switch index {
        case .first: return mediator.coalescedValue.first
        case .second: return mediator.coalescedValue.second
        }
    }
}
