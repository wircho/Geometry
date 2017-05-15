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
    var appearance = StrokeAppearance()
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
        return ruler?.result.arrow.vector.orthogonal ?? .none
    }
}

