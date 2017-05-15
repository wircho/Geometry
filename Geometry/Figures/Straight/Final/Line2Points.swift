//
//  Line2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Line2Points: Figure, Ruler2Points, Line {
    var appearance = StrokeAppearance()
    var storage = FigureStorage<RawRuler>()
    var rulerStorage = RulerStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var point0: Point?
    weak var point1: Point?
    
    let parentOrder = ParentOrder.unsorted
    
    init(_ p0: Point, _ p1: Point) {
        point0 = p0
        point1 = p1
        appendToContext()
    }
}
