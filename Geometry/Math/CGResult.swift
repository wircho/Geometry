//
//  CGResult.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: Result types

typealias RCGFloat = Result<CGFloat, CGError>
typealias RCGPoint = Result<CGPoint, CGError>
typealias RCGCircle = Result<CGCircle, CGError>
typealias RCGArrow = Result<CGArrow, CGError>
typealias RCGStraight = Result<CGStraight, CGError>
typealias RCG2x2 = Result<CG2x2, CGError>
typealias RCG2 = Result<CG2, CGError>
typealias RCGPoint2 = Result<CGPoint2, CGError>

// MARK: Result extensions

extension Result where T: CGPointProtocol {
    typealias RCGFloat = Result<CGFloat, Error>
    
    var x: RCGFloat {
        return self.map { $0.x }
    }
    
    var y: RCGFloat {
        return self.map { $0.y }
    }
    
    init (x: CGFloat, y: CGFloat) {
        self = .success(T(x: x, y: y))
    }
    
    init (x: RCGFloat, y: RCGFloat) {
        self = x.flatMap { x in return y.map { y in return T(x: x, y: y) } }
    }
    
    var squaredNorm: RCGFloat {
        return map { $0.squaredNorm }
    }
    
    var norm: RCGFloat {
        return map { $0.norm }
    }
}

extension Result where T: CGCircleProtocol {
    typealias RCGPoint = Result<CGPoint, Error>
    
    var center: RCGPoint {
        return self.map { $0.center }
    }
    
    var radius: RCGFloat {
        return self.map { $0.radius }
    }
    
    init (center: CGPoint, radius: CGFloat) {
        self = .success(T(center: center, radius: radius))
    }
    
    init (center: RCGPoint, radius: RCGFloat) {
        self = center.flatMap { center in return radius.map { radius in return T(center: center, radius: radius) } }
    }
    
    init (center: RCGPoint, point: RCGPoint) {
        self = center.flatMap { center in return point.map { point in return T(center: center, point: point) } }
    }
}

extension Result where T: CGArrowProtocol {
    var point0: RCGPoint {
        return self.map { $0.points.0 }
    }
    
    var point1: RCGPoint {
        return self.map { $0.points.1 }
    }
    
    init(points: (RCGPoint, RCGPoint)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(points: (p0, p1)) } }
    }
}

extension Result where T: CGStraightProtocol {
    typealias RCGArrow = Result<CGArrow, Error>
    
    init(kind: CGStraight.Kind, arrow: RCGArrow) {
        self = arrow.map { T(kind: kind, arrow: $0) }
    }
    
    init(kind: CGStraight.Kind, points: (RCGPoint, RCGPoint)) {
        self = points.0.flatMap { p0 in points.1.map { p1 in T(kind: kind, points: (p0, p1)) } }
    }
}

extension Result where T: CGPoint2Protocol,  Error: CGErrorProtocol {
    var first: RCGPoint {
        return self.flatMap {
            guard let first = $0.first else {
                return .none
            }
            return .success(first)
        }
    }
    
    var second: RCGPoint {
        return self.flatMap {
            guard let second = $0.second else {
                return .none
            }
            return .success(second)
        }
    }
}

extension Result where Error: CGErrorProtocol {
    static var none: Result {
        return .failure(Error(.none))
    }
}

