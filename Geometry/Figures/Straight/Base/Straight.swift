//
//  Ruler.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Ruler Base Class

private let one = Result<Float, MathError>.success(1)

protocol Ruler: FigureBase, OneDimensional, Appears, Drawable {
    var result: RawRulerResult { get }
    var rulerStorage: RulerStorage { get set }
    func calculateArrow() -> ArrowResult
    var kind: RawRuler.Kind { get }
}

struct RulerStorage {
    var normReciprocal: Float? = nil
}

extension Ruler {
    func recalculate() -> RawRulerResult {
        let arrow = calculateArrow()
        rulerStorage.normReciprocal = (one / arrow.vector.norm).value
        return RawRulerResult(kind: kind, arrow: arrow)
    }
    
    func drawIn(_ rect: CGRect) {
        guard let ruler = result.value, let exits:Two<RawPoint?> = intersections(ruler, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? ruler.arrow.points.0,  exits.v1 ?? ruler.arrow.points.1)
        color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: lineWidth).stroke()
    }
}

protocol Line: Ruler { }
protocol Segment: Ruler { }
protocol Ray: Ruler { }

extension Line { var kind: RawRuler.Kind { return .line } }
extension Segment { var kind: RawRuler.Kind { return .segment } }
extension Ray { var kind: RawRuler.Kind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
