//
//  TwoRulers.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

import CoreGraphics
import Result

final class TwoRulerMediator: Figure {
    var storage = FigureStorage<RawPoint>()
    weak var existing: Point?
    
    weak var ruler0: Ruler?
    weak var ruler1: Ruler?
    
    init(_ s0: Ruler, _ s1: Ruler) {
        ruler0 = s0
        ruler1 = s1
        s0.findCommonPoints(with: s1) {
            existing = $0
            return false
        }
        appendToContext()
    }
    
    func recalculate() -> RawPointResult {
        return intersection(ruler0?.result ?? .none, ruler1?.result ?? .none)
    }
}

class TwoRulerIntersection: Figure, Point {
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<RawPoint>()
    
    weak var mediator: TwoRulerMediator?
    
    init(_ mediator: TwoRulerMediator) {
        self.mediator = mediator
        mediator.ruler0?.intersectionPoints.append(self)
        mediator.ruler1?.intersectionPoints.append(self)
        appendToContext()
    }
    
    func recalculate() -> RawPointResult {
        guard let mediator = mediator, mediator.existing == nil else { return .none }
        return mediator.result
    }
    
    static func create(_ s0: Ruler, _ s1: Ruler) -> (mediator: TwoRulerMediator, intersection: TwoRulerIntersection?) {
        let mediator = TwoRulerMediator(s0, s1)
        guard mediator.existing == nil else { return (mediator, nil) }
        return (mediator, TwoRulerIntersection(mediator))
    }
}
