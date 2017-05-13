//
//  DirectedLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

class DirectedLine: Straight, LineProtocol {
    weak var point: Point?
    weak var straight: Straight?
    
    init(_ point: Point, _ straight: Straight) {
        self.point = point
        self.straight = straight
        super.init(sorted: [point, straight])
    }
    
    func calculateArrow() -> ArrowResult {
        guard let point = point, let straight = straight else {
            return .none
        }
        return ArrowResult(points: (point.result, point.result + straight.result.arrow.vector))
    }
    
    override func at(_ pos: Float) -> Spot? {
        guard let value = result.value, let normReciprocal = normReciprocal else { return nil }
        return value.arrow.at(pos * normReciprocal)
    }
}
