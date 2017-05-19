//
//  Ruler.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Ruler Base Class

private let one = Result<CGFloat, MathError>.success(1)

protocol Ruler: FigureBase, OneDimensional, StrokeAppears, Touchable {
    var result: RawRulerResult { get }
    var rulerStorage: RulerStorage { get set }
    func calculateArrow() -> ArrowResult
    var kind: RawRuler.Kind { get }
}

extension Ruler {
    func recalculate() -> RawRulerResult {
        let arrow = calculateArrow()
        return RawRulerResult(kind: kind, arrow: arrow)
    }
    
    func drawIn(_ rect: CGRect, appearance: StrokeAppearance) {
        guard let ruler = result.value, let exits:Two<RawPoint?> = intersections(ruler, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? ruler.arrow.points.0,  exits.v1 ?? ruler.arrow.points.1)
        appearance.color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: appearance.lineWidth).stroke()
    }
    
    var appearance: StrokeAppearance {
        get { return rulerStorage.appearance }
        set { rulerStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawRuler> {
        get { return rulerStorage.figureStorage }
        set { rulerStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage {
        get { return rulerStorage.oneDimensionalStorage }
        set { rulerStorage.oneDimensionalStorage = newValue }
    }
    
    var normReciprocal: FloatResult {
        if let nRec = rulerStorage._normReciprocal {
            return nRec
        } else {
            let nRec = one / result.arrow.vector.norm
            rulerStorage._normReciprocal = nRec
            return nRec
        }
    }
}

struct RulerStorage {
    var _normReciprocal: FloatResult? = nil
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawRuler>() {
        didSet {
            _normReciprocal = nil
        }
    }
    var oneDimensionalStorage = OneDimensionalStorage()
}

protocol Line: Ruler { }
protocol Segment: Ruler { }
protocol Ray: Ruler { }

extension Line {
    var kind: RawRuler.Kind { return .line }
    
    func gapToCenter(from point: RawPoint) -> FloatResult {
        return result.flatMap { ruler in
            ruler.arrow.project(point).map { pos in
                distance(point, ruler.arrow.at(pos))
            }
        }
    }
    
    var touchPriority: CGFloat { return 700 }
}

extension Ray {
    var kind: RawRuler.Kind { return .ray }
    
    func gapToCenter(from point: RawPoint) -> FloatResult {
        return result.flatMap {
            ruler in
            return ruler.arrow.project(point).map {
                pos in
                if pos < 0 {
                    return distance(point, ruler.arrow.points.0)
                } else {
                    return distance(point, ruler.arrow.at(pos))
                }
            }
        }
    }
    
    var touchPriority: CGFloat { return 800 }
}

extension Segment {
    var kind: RawRuler.Kind { return .segment }
    
    func gapToCenter(from point: RawPoint) -> FloatResult {
        return result.flatMap {
            ruler in
            return ruler.arrow.project(point)
                .map {
                    pos in
                    if pos < 0 {
                        return distance(point, ruler.arrow.points.0)
                    } else if pos > 1 {
                        return distance(point, ruler.arrow.points.1)
                    } else {
                        return distance(point, ruler.arrow.at(pos))
                    }
                }
                .flatMapError { _ in .success(distance(point, ruler.arrow.points.0)) }
        }
    }
    
    var touchPriority: CGFloat { return 900 }
}

// TODO: - Angle bisector, Perpendicular Bisector
