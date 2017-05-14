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
    var appearance = Appearance()
    var storage = FigureStorage<RawRuler>()
    var rulerStorage = RulerStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var point: Point?
    weak var ruler: Ruler?
    
    init(_ point: Point, _ ruler: Ruler) {
        self.point = point
        self.ruler = ruler
        appendToContext()
    }
    
    func calculateArrowDirection() -> RawPointResult {
        return ruler?.result.arrow.vector ?? .none
    }
}
