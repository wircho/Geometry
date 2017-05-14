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

final class TwoCircleMediator: Figure {
    var storage = FigureStorage<TwoSpot>()
    
    var existing: CoupleOfPoints = .none
    
    weak var circle0: Circle?
    weak var circle1: Circle?
    
    init(_ cl0: Circle, _ cl1: Circle) {
        let (c0, c1) = (cl0.cedula.value < cl1.cedula.value) ? (cl0, cl1) : (cl1, cl0)
        circle0 = c0
        circle1 = c1
        c0.findCommonPoints(with: c1) { existing.add($0) }
        appendToContext()
    }
    
    func recalculate() -> TwoSpotResult {
        switch existing {
        case .none:
            return intersections(circle0?.result ?? .none, circle1?.result ?? .none)
        case let .one(pt):
            guard let point = pt.point else { return .none }
            return TwoSpotResult(v0: point.result, v1: ArrowResult(points: (circle0?.result.center ?? .none, circle1?.result.center ?? .none)).reflect(point.result))
        case .two:
            return .none
        }
    }
}

// MARK: - Intersection Point

final class TwoCircleIntersection: Figure, Point {
    enum Index {
        case first
        case second
    }
    
    var appearance = Appearance(radiusMultiplier: 3)
    var storage = FigureStorage<Spot>()
    
    weak var mediator: TwoCircleMediator?
    var index: Index
    
    init(_ mediator: TwoCircleMediator, _ index: Index) {
        self.mediator = mediator
        self.index = index
        mediator.circle0?.intersectionPoints.append(self)
        mediator.circle1?.intersectionPoints.append(self)
        appendToContext()
    }
    
    static func create(_ c0: Circle, _ c1: Circle) -> (mediator: TwoCircleMediator, intersection0: TwoCircleIntersection?, intersection0: TwoCircleIntersection?) {
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
    
    func recalculate() -> SpotResult {
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
