//
//  Straight2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Figures Through 2 Points

protocol Straight2Points: Straight {
    var point0: Point? { get }
    var point1: Point? { get }
    
    init(_ p0: Point, _ p1: Point)
}

extension Straight2Points {
    func calculateArrow() -> ArrowResult {
        let p0 = point0?.result ?? .none
        let p1 = point1?.result ?? .none
        return ArrowResult(points: (p0, p1))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1].flatMap { $0 }
    }
    
    func at(_ pos: Float) -> Spot? {
        guard let value = result.value, let normReciprocal = straightStorage.normReciprocal else { return nil }
        switch value.kind {
        case .line: return value.arrow.at(pos)
        case .segment: return value.arrow.at(min(max(pos,0),1))
        case .ray: return value.arrow.at(max(pos,0) * normReciprocal)
        }
    }
}
