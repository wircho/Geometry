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
    var storage = FigureStorage<Saber>()
    var straightStorage = StraightStorage()
    var oneDimensionalStorage = OneDimensionalStorage()
    
    weak var point: Point?
    weak var straight: Straight?
    
    init(_ point: Point, _ straight: Straight) {
        self.point = point
        self.straight = straight
        appendToContext()
    }
    
    func calculateArrowDirection() -> SpotResult {
        return straight?.result.arrow.vector ?? .none
    }
}
