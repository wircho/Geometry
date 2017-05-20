//
//  TwoRulers.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

import CoreGraphics
import Result

final class TwoRulerMediator: Figure, ParentComparable {
    var storage = FigureStorage<RawPoint>()
    weak var existing: Point?
    
    weak var ruler0: Ruler?
    weak var ruler1: Ruler?
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return [ruler0, ruler1] }
    
    init(_ s0: Ruler, _ s1: Ruler) {
        ruler0 = s0
        ruler1 = s1
        s0.findCommonPoints(with: s1) {
            existing = $0
            return false
        }
        setChildOf([s0, s1])
    }
    
    func recalculate() -> Res<RawPoint> {
        guard existing == nil else { return .none }
        return intersection(ruler0?.result ?? .none, ruler1?.result ?? .none)
    }
}

class TwoRulerIntersection: Figure, Point {
    var pointStorage = PointStorage()
    
    weak var mediator: TwoRulerMediator?
    
    init(_ mediator: TwoRulerMediator) {
        self.mediator = mediator
        mediator.ruler0?.intersectionPoints.append(self)
        mediator.ruler1?.intersectionPoints.append(self)
        setChildOf([mediator])
    }
    
    func compare(with other: TwoRulerIntersection) -> Bool {
        guard let mediator = mediator, let otherMediator = other.mediator else { return false }
        return mediator === otherMediator
    }
    
    func recalculate() -> Res<RawPoint> {
        guard let mediator = mediator, mediator.existing == nil else { return .none }
        return mediator.result
    }
    
    static func create(_ s0: Ruler, _ s1: Ruler) -> (mediator: TwoRulerMediator, intersection: TwoRulerIntersection?) {
        let mediator = TwoRulerMediator(s0, s1)
        guard mediator.existing == nil else { return (mediator, nil) }
        return (mediator, TwoRulerIntersection(mediator))
    }
}
