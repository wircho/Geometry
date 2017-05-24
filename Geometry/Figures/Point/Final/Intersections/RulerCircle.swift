//
//  RulerCircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

final class RulerCircleMediator: Figure, ParentComparable {
    var storage = FigureStorage<Two<RawPoint?>>()
    
    var existing: CoupleOfPoints = .none
    
    weak var ruler: Ruler?
    weak var circle: Circle?
    
    let parentOrder = ParentOrder.sorted
    var parents: [AnyObject?] { return [ruler, circle] }
    
    init(_ ruler: Ruler, _ circle: Circle) {
        self.ruler = ruler
        self.circle = circle
        ruler.findCommonPoints(with: circle) { existing.add($0) }
        setChildOf([ruler, circle])
    }
    
    func recalculate() -> Res<Two<RawPoint?>> {
        switch existing {
        case .none:
            return intersections(ruler?.result ?? .none, circle?.result ?? .none)
        case let .one(pt):
            guard let point = pt.point else { return .none }
            let arrow = (ruler?.result ?? .none).arrow
            let centerProj = arrow.project((circle?.result ?? .none).center)
            let pointProj = arrow.project(point.result)
            let p0 = (point.result).map { $0 as RawPoint? }
            let p1 = arrow.at(offset: (2 * centerProj - pointProj)).map { $0 as RawPoint? }
            return Res<Two<RawPoint?>>(v0: p0, v1: p1)
        case .two:
            return .none
        }
    }
}

// MARK: - Intersection Point

final class RulerCircleIntersection: Figure, Point {
    enum Index {
        case first
        case second
    }
    
    var pointStorage = PointStorage()
    
    weak var mediator: RulerCircleMediator?
    var index: Index
    
    init(_ mediator: RulerCircleMediator, _ index: Index) {
        self.mediator = mediator
        self.index = index
        mediator.ruler?.intersectionPoints.append(self)
        mediator.circle?.intersectionPoints.append(self)
        setChildOf([mediator])
    }
    
    func compare(with other: RulerCircleIntersection) -> Bool {
        guard let mediator = mediator, let otherMediator = other.mediator else { return false }
        return mediator === otherMediator && index == other.index
    }
    
    static func create(_ ruler: Ruler, _ circle: Circle) -> (mediator: RulerCircleMediator, intersection0: RulerCircleIntersection?, intersection0: RulerCircleIntersection?) {
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
    
    func recalculate() -> Res<RawPoint> {
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
