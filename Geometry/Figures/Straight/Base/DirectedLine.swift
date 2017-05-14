//
//  DirectedLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol DirectedLine: Ruler, Line {
    var point: Point? { get }
    var ruler: Ruler? { get }
    func calculateArrowDirection() -> RawPointResult
    init(_ point: Point, _ ruler: Ruler)
    
}

extension DirectedLine {
    func calculateArrow() -> ArrowResult {
        let p = point?.result ?? .none
        return ArrowResult(points: (p, p + calculateArrowDirection()))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point].flatMap { $0 }
    }
    
    func at(_ pos: Float) -> RawPoint? {
        guard let value = result.value, let normReciprocal = rulerStorage.normReciprocal else { return nil }
        return value.arrow.at(pos * normReciprocal)
    }
}
