//
//  StraightCircle.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

class StraightCircleMediator: Figure<CGPoint2> {
    var straight: Getter<RCGStraight>
    var circle: Getter<RCGCircle>
    
    init(straight: Straight, circle: Circle) {
        self.straight = straight.getter
        self.circle = circle.getter
        super.init(straight, circle)
    }
    
    override func getRaw() -> RCGPoint2 {
        return intersections(straight.value, circle.value)
    }
}

// MARK: - Intersection Point

class StraightCircleIntersection: Point {
    enum Index {
        case first
        case second
    }
    
    var mediator: Getter<RCGPoint2>
    var index: Index
    
    init(mediator: StraightCircleMediator, index: Index) {
        self.mediator = mediator.getter
        self.index = index
        super.init(mediator)
    }
    
    override func getRaw() -> Result<CGPoint, CGError> {
        switch index {
        case .first: return mediator.value.first
        case .second: return mediator.value.second
        }
    }
}
