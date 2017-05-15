//
//  PerpendicularLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class PerpendicularLine: Figure, DirectedLine {
    var directedLineStorage: DirectedLineStorage
    init (_ s: DirectedLineStorage) { directedLineStorage = s }
    
    func calculateArrowDirection() -> RawPointResult {
        return ruler?.result.arrow.vector.orthogonal ?? .none
    }
}

