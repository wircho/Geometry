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

final class TwoCircleMediator<C: RawCircleProtocol>: Figure, ParentComparable {
    var storage = FigureStorage<Two<C.Point>>()
    
    var existing: CoupleOfPoints<C.Point> = .none
    
    var circle0: AnyWeakOneDimensional<C, C.Point>
    var circle1: AnyWeakOneDimensional<C, C.Point>
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return [circle0.anyWeakFigure.figure, circle1.anyWeakFigure.figure] }
    
    init<O0: Circle, O1: Circle>(_ cl0: O0, _ cl1: O1) where O0.ResultValue == Res<C>, O1.ResultValue == Res<C>, O0.P == C.Point, O1.P == C.Point {
        let ac0 = AnyWeakOneDimensional<C, C.Point>(cl0)
        let ac1 = AnyWeakOneDimensional<C, C.Point>(cl1)
        let (c0, c1) = (cl0.cedula.value < cl1.cedula.value) ? (ac0, ac1) : (ac1, ac0)
        circle0 = c0
        circle1 = c1
        cl0.findCommonPoints(with: cl1) { existing.add($0) }
        setChildOf([cl0, cl1])
    }
    
    func recalculate() -> Res<Two<C.Point>> {
        switch existing {
        case .none:
            return intersections(circle0.anyWeakFigure.result ?? .none, circle1.anyWeakFigure.result ?? .none)
        case let .one(pt):
            guard let pointResult = pt.point.result else { return .none }
            return Res<Two<C.Point>>(v0: pointResult, v1: Res<Arrow<C.Point>>(points: (circle0.anyWeakFigure.result?.center ?? .none, circle1.anyWeakFigure.result?.center ?? .none)).reflect(pointResult))
        case .two:
            return .none
        }
    }
}

// MARK: - Intersection Point

final class TwoCircleIntersection<C: RawCircleProtocol>: Point {
    enum Index {
        case first
        case second
    }
    
    var pointStorage = PointStorage<C.Point>()
    
    weak var mediator: TwoCircleMediator<C>?
    var index: Index
    
    init(_ mediator: TwoCircleMediator<C>, _ index: Index) {
        self.mediator = mediator
        self.index = index
        mediator.circle0.intersectionPoints.append(AnyFigure(self))
        mediator.circle1.intersectionPoints.append(AnyFigure(self))
        setChildOf([mediator])
    }
    
    func compare(with other: TwoCircleIntersection) -> Bool {
        guard let mediator = mediator, let otherMediator = other.mediator else { return false }
        return mediator === otherMediator && index == other.index
    }
    
    static func create<O0: Circle, O1: Circle>(_ c0: O0, _ c1: O1) -> (mediator: TwoCircleMediator<C>, intersection0: TwoCircleIntersection?, intersection0: TwoCircleIntersection?) where O0.ResultValue == Res<C>, O1.ResultValue == Res<C>, O0.P == C.Point, O1.P == C.Point {
        let mediator = TwoCircleMediator(c0, c1)
        switch mediator.existing {
        case .none:
            return (
                mediator,
                TwoCircleIntersection(mediator, .first),
                TwoCircleIntersection(mediator, .second)
            )
        case .one:
            return (
                mediator,
                nil,
                TwoCircleIntersection(mediator, .second)
            )
        case .two:
            return (mediator, nil, nil)
        }
    }
    
    func recalculate() -> Res<C.Point> {
        guard let mediator = mediator else { return .none }
        switch mediator.existing {
        case .two: return .none
        default:
            switch index {
            case .first: return mediator.result.v0
            case .second: return mediator.result.v1
            }
        }
    }
}
