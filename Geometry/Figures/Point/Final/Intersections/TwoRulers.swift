//
//  TwoRulers.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

import CoreGraphics
import Result

final class TwoRulerMediator<R: RawRulerProtocol>: Figure, ParentComparable {
    var storage = FigureStorage<R.Arrow.Point>()
    var existing: AnyWeakFigure<R.Arrow.Point>? = nil
    
    var ruler0: AnyWeakOneDimensional<R, R.Arrow.Point>
    var ruler1: AnyWeakOneDimensional<R, R.Arrow.Point>
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return [ruler0.anyWeakFigure.figure, ruler1.anyWeakFigure.figure] }
    
    init<S0: Ruler, S1: Ruler>(_ s0: S0, _ s1: S1) where S0.ResultValue == Res<R>, S1.ResultValue == Res<R>, S0.P == R.Arrow.Point, S1.P == R.Arrow.Point {
        ruler0 = AnyWeakOneDimensional(s0)
        ruler1 = AnyWeakOneDimensional(s1)
        s0.findCommonPoints(with: s1) {
            existing = $0.anyWeakFigure
            return false
        }
        setChildOf([s0, s1])
    }
    
    func recalculate() -> Res<R.Arrow.Point> {
        guard existing == nil else { return .none }
        return intersection(ruler0.anyWeakFigure.result ?? .none, ruler1.anyWeakFigure.result ?? .none)
    }
}

class TwoRulerIntersection<R: RawRulerProtocol>: Point {
    var pointStorage = PointStorage<R.Arrow.Point>()
    
    weak var mediator: TwoRulerMediator<R>?
    
    init(_ mediator: TwoRulerMediator<R>) {
        self.mediator = mediator
        mediator.ruler0.intersectionPoints.append(AnyFigure(self))
        mediator.ruler1.intersectionPoints.append(AnyFigure(self))
        setChildOf([mediator])
    }
    
    func compare(with other: TwoRulerIntersection) -> Bool {
        guard let mediator = mediator, let otherMediator = other.mediator else { return false }
        return mediator === otherMediator
    }
    
    func recalculate() -> Res<R.Arrow.Point> {
        guard let mediator = mediator, mediator.existing == nil else { return .none }
        return mediator.result
    }
    
    static func create<S0: Ruler, S1: Ruler>(_ s0: S0, _ s1: S1) -> (mediator: TwoRulerMediator<R>, intersection: TwoRulerIntersection<R>?) where S0.ResultValue == Res<R>, S1.ResultValue == Res<R>, S0.P == R.Arrow.Point, S1.P == R.Arrow.Point {
        let mediator = TwoRulerMediator(s0, s1)
        guard mediator.existing == nil else { return (mediator, nil) }
        return (mediator, TwoRulerIntersection(mediator))
    }
}
