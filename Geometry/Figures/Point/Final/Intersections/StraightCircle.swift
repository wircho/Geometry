//
//  StraightCircle.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Intersection Mediator

final class StraightCircleMediator: Figure {
    var storage = FigureStorage<Two<Spot?>>()
    
    var existing: CoupleOfPoints = .none
    
    weak var straight: Straight?
    weak var circle: Circle?
    
    init(_ straight: Straight, _ circle: Circle) {
        self.straight = straight
        self.circle = circle
        straight.findCommonPoints(with: circle) { existing.add($0) }
        appendToContext()
    }
    
    func recalculate() -> TwoOptionalSpotResult {
        switch existing {
        case .none:
            // TODO: Just return!
            let r = intersections(straight?.result ?? .none, circle?.result ?? .none)
            return r
        case let .one(pt):
            guard let point = pt.point else { return .none }
            let arrow = (straight?.result ?? .none).arrow
            let centerProj = arrow.project((circle?.result ?? .none).center)
            let pointProj = arrow.project(point.result)
            let p0 = (point.result).map { $0 as Spot? }
            let p1 = arrow.at((2 * centerProj - pointProj)).map { $0 as Spot? }
            return TwoOptionalSpotResult(v0: p0, v1: p1)
        case .two:
            return .none
        }
    }
}

// MARK: - Intersection Point

final class StraightCircleIntersection: Figure, Point {
    enum Index {
        case first
        case second
    }
    
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<Spot>()
    
    weak var mediator: StraightCircleMediator?
    var index: Index
    
    init(_ mediator: StraightCircleMediator, _ index: Index) {
        self.mediator = mediator
        self.index = index
        mediator.straight?.intersectionPoints.append(self)
        mediator.circle?.intersectionPoints.append(self)
        appendToContext()
    }
    
    static func create(_ straight: Straight, _ circle: Circle) -> (mediator: StraightCircleMediator, intersection0: StraightCircleIntersection?, intersection0: StraightCircleIntersection?) {
        let mediator = StraightCircleMediator(straight, circle)
        switch mediator.existing {
        case .none:
            return (
                mediator,
                StraightCircleIntersection(mediator, .first),
                StraightCircleIntersection(mediator, .second)
            )
        case .one:
            return (
                mediator,
                nil,
                StraightCircleIntersection(mediator, .second)
            )
        case .two:
            return (mediator, nil, nil)
        }
    }
    
    func recalculate() -> SpotResult {
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
