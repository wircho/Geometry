//
//  CoupleOfPoints.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct OnePoint {
    weak var point: Point?
    init(_ point: Point) {
        self.point = point
    }
}

struct TwoPoints {
    weak var point0: Point?
    weak var point1: Point?
    init(_ point0: Point?, _ point1: Point?) {
        self.point0 = point0
        self.point1 = point1
    }
}

enum CoupleOfPoints {
    case none
    case one(OnePoint)
    case two(TwoPoints)
    
    mutating func add(_ point: Point) -> Bool {
        switch self {
        case .none:
            self = .one(OnePoint(point))
            return true
        case let .one(pt):
            self = .two(TwoPoints(pt.point, point))
            fallthrough
        case .two:
            return false
        }
    }
}
