//
//  TwoStraights.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

import CoreGraphics
import Result

final class TwoStraightMediator: Figure {
    var storage = FigureStorage<Spot>()
    weak var existing: Point?
    
    weak var straight0: Straight?
    weak var straight1: Straight?
    
    init(_ s0: Straight, _ s1: Straight) {
        straight0 = s0
        straight1 = s1
        s0.findCommonPoints(with: s1) {
            existing = $0
            return false
        }
        appendToContext()
    }
    
    func recalculate() -> SpotResult {
        return intersection(straight0?.result ?? .none, straight1?.result ?? .none)
    }
}

class TwoStraightIntersection: Figure, Point {
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<Spot>()
    
    weak var mediator: TwoStraightMediator?
    
    init(_ mediator: TwoStraightMediator) {
        self.mediator = mediator
        mediator.straight0?.intersectionPoints.append(self)
        mediator.straight1?.intersectionPoints.append(self)
        appendToContext()
    }
    
    func recalculate() -> SpotResult {
        guard let mediator = mediator, mediator.existing == nil else { return .none }
        return mediator.result
    }
    
    static func create(_ s0: Straight, _ s1: Straight) -> (mediator: TwoStraightMediator, intersection: TwoStraightIntersection?) {
        let mediator = TwoStraightMediator(s0, s1)
        guard mediator.existing == nil else { return (mediator, nil) }
        return (mediator, TwoStraightIntersection(mediator))
    }
}
