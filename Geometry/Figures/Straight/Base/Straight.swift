//
//  Straight.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Base Class

private let one = Result<Float, MathError>.success(1)

protocol Straight: FigureBase, OneDimensional, Appears, Drawable {
    var result: SaberResult { get }
    var straightStorage: StraightStorage { get set }
    func calculateArrow() -> ArrowResult
    var kind: Saber.Kind { get }
}

struct StraightStorage {
    var normReciprocal: Float? = nil
}

extension Straight {
    func recalculate() -> SaberResult {
        let arrow = calculateArrow()
        straightStorage.normReciprocal = (one / arrow.vector.norm).value
        return SaberResult(kind: kind, arrow: arrow)
    }
    
    func drawIn(_ rect: CGRect) {
        guard let saber = result.value, let exits:Two<Spot?> = intersections(saber, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? saber.arrow.points.0,  exits.v1 ?? saber.arrow.points.1)
        color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: lineWidth).stroke()
    }
}

protocol Line: Straight { }
protocol Segment: Straight { }
protocol Ray: Straight { }

extension Line { var kind: Saber.Kind { return .line } }
extension Segment { var kind: Saber.Kind { return .segment } }
extension Ray { var kind: Saber.Kind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
