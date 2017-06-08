//
//  RulerCircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

final class RulerCircleMediator<R: RawRulerProtocol, C: RawCircleProtocol>: Figure, ParentComparable where R.Arrow.Point == C.Point {
    var storage = FigureStorage<Two<R.Arrow.Point?>>()
    
    var existing: CoupleOfPoints<R.Arrow.Point> = .none
    
    var ruler: AnyWeakOneDimensional<R, R.Arrow.Point>
    var circle: AnyWeakOneDimensional<C, C.Point>
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [ruler.anyWeakFigure.figure, circle.anyWeakFigure.figure] }
    
    init<L: Ruler, O: Circle>(_ ruler: L, _ circle: O) where L.ResultValue == Res<R>, O.ResultValue == Res<C>,  L.P == R.Arrow.Point, O.P == C.Point {
        self.ruler = AnyWeakOneDimensional(ruler)
        self.circle = AnyWeakOneDimensional(circle)
        ruler.findCommonPoints(with: circle) { existing.add($0) }
        setChildOf([ruler, circle])
    }
    
    func recalculate() -> Res<Two<R.Arrow.Point?>> {
        switch existing {
        case .none:
            return intersections(ruler.anyWeakFigure.result ?? .none, circle.anyWeakFigure.result ?? .none)
        case let .one(pt):
            guard let pointResult = pt.point.result else { return .none }
            let arrow = (ruler.anyWeakFigure.result ?? .none).arrow
            let centerProj = arrow.project((circle.anyWeakFigure.result ?? .none).center)
            let pointProj = arrow.project(pointResult)
            let p0 = pointResult.map { $0 as R.Arrow.Point? }
            let p1 = arrow.at(offset: (2 * centerProj - pointProj)).map { $0 as R.Arrow.Point? }
            return Res<Two<R.Arrow.Point?>>(v0: p0, v1: p1)
        case .two:
            return .none
        }
    }
}

// MARK: - Intersection Point

final class RulerCircleIntersection<R: RawRulerProtocol, C: RawCircleProtocol>: Point where R.Arrow.Point == C.Point {
    enum Index {
        case first
        case second
    }
    
    var pointStorage = PointStorage<R.Arrow.Point>()
    
    weak var mediator: RulerCircleMediator<R, C>?
    var index: Index
    
    init(_ mediator: RulerCircleMediator<R, C>, _ index: Index) {
        self.mediator = mediator
        self.index = index
        mediator.ruler.intersectionPoints.append(AnyFigure(self))
        mediator.circle.intersectionPoints.append(AnyFigure(self))
        setChildOf([mediator])
    }
    
    func compare(with other: RulerCircleIntersection) -> Bool {
        guard let mediator = mediator, let otherMediator = other.mediator else { return false }
        return mediator === otherMediator && index == other.index
    }
    
    static func create<L: Ruler, O: Circle>(_ ruler: L, _ circle: O) -> (mediator: RulerCircleMediator<R, C>, intersection0: RulerCircleIntersection?, intersection0: RulerCircleIntersection?) where L.ResultValue == Res<R>, O.ResultValue == Res<C>,  L.P == R.Arrow.Point, O.P == C.Point {
        let mediator = RulerCircleMediator(ruler, circle)
        switch mediator.existing {
        case .none:
            return (
                mediator,
                RulerCircleIntersection(mediator, .first),
                RulerCircleIntersection(mediator, .second)
            )
        case .one:
            return (
                mediator,
                nil,
                RulerCircleIntersection(mediator, .second)
            )
        case .two:
            return (mediator, nil, nil)
        }
    }
    
    func recalculate() -> Res<R.Arrow.Point> {
        guard let mediator = mediator else { return .none }
        switch mediator.existing {
        case .two: return .none
        default:
            switch index {
            case .first: return mediator.result.v0.optional ?? .none
            case .second: return mediator.result.v1.optional ?? .none
            }
        }
    }
}
