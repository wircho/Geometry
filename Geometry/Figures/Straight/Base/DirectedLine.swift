//
//  DirectedLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol DirectedLine: Straight, Line {
    var point: Point? { get }
    var straight: Straight? { get }
    func calculateArrowDirection() -> SpotResult
    init(_ point: Point, _ straight: Straight)
    
}

extension DirectedLine {
    func calculateArrow() -> ArrowResult {
        let p = point?.result ?? .none
        return ArrowResult(points: (p, p + calculateArrowDirection()))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point].flatMap { $0 }
    }
    
    func at(_ pos: Float) -> Spot? {
        guard let value = result.value, let normReciprocal = straightStorage.normReciprocal else { return nil }
        return value.arrow.at(pos * normReciprocal)
    }
}
