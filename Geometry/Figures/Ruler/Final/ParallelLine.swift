//
//  ParallelLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class ParallelLine: Figure, DirectedLine {
    var directedLineStorage: DirectedLineStorage
    init (_ s: DirectedLineStorage) { directedLineStorage = s }
    
    func calculateArrowDirection() -> Res<RawPoint> {
        return ruler?.result.arrow.vector ?? .none
    }
}
