//
//  ParallelLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class ParallelLine: DirectedLine {
    override func calculateArrow() -> ArrowResult {
        guard let point = point, let straight = straight else {
            return .none
        }
        return ArrowResult(points: (point.result, point.result + straight.result.arrow.vector))
    }
}
