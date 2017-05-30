//
//  ParallelLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class ParallelLine<R: RawRulerProtocol>: DirectedLine {
    var directedLineStorage: DirectedLineStorage<R>
    init (_ s: DirectedLineStorage<R>) { directedLineStorage = s }
    
    func calculateArrowDirection() -> Res<R.Arrow.Point> {
        return ruler.result?.arrow.vector ?? .none
    }
}
