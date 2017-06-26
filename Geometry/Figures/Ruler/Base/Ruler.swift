//
//  Ruler.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Ruler Base Class

protocol Ruler: OneDimensional {
    associatedtype R: RawRulerProtocol
    var rulerStorage: RulerStorage<R> { get set }
    var result: Res<R> { get }
    func calculateArrow() -> Res<R.Arrow>
    var kind: RulerKind { get }
}

extension Ruler {
    func update() -> Res<R> {
        let arrow = calculateArrow()
        return Res<R>(kind: kind, arrow: arrow)
    }
    
    var storage: FigureStorage<R> {
        get { return rulerStorage.figureStorage }
        set { rulerStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage<R.Arrow.Point> {
        get { return rulerStorage.oneDimensionalStorage }
        set { rulerStorage.oneDimensionalStorage = newValue }
    }
    
    var normReciprocal: Res<R.Arrow.Point.Value> {
        if let nRec = rulerStorage._normReciprocal {
            return nRec
        } else {
            let nRec = Result.success(1) / result.arrow.vector.norm
            rulerStorage._normReciprocal = nRec
            return nRec
        }
    }
}

struct RulerStorage<R: RawRulerProtocol> {
    var _normReciprocal: Res<R.Arrow.Point.Value>? = nil
    /*var appearance = StrokeAppearance() */
    var figureStorage = FigureStorage<R>() {
        didSet {
            _normReciprocal = nil
        }
    }
    var oneDimensionalStorage = OneDimensionalStorage<R.Arrow.Point>()
}

protocol Line: Ruler { }
protocol Segment: Ruler { }
protocol Ray: Ruler { }

extension Line {
    var kind: RulerKind { return .line }
    
    func gap(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.flatMap { ruler in
            ruler.arrow.project(point).map { pos in
                distance(point, ruler.arrow.at(offset: pos))
            }
        }
    }
    /*
    var touchPriority: CGFloat { return 700 }*/
}

extension Ray {
    var kind: RulerKind { return .ray }
    
    func at(offset: R.Arrow.Point.Value) -> Res<R.Arrow.Point> {
        return result.flatMap {
            value in
            normReciprocal.map {
                normReciprocal in
                value.arrow.at(offset: max(offset,0) * normReciprocal)
            }
        }
    }
    
    func nearestOffset(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.arrow.projectIso(point).map { max($0, 0) }
    }
    
    func gap(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.flatMap {
            ruler in
            return ruler.arrow.project(point).map {
                pos in
                if pos < 0 {
                    return distance(point, ruler.arrow.points.0)
                } else {
                    return distance(point, ruler.arrow.at(offset: pos))
                }
            }
        }
    }
    
    /*var touchPriority: CGFloat { return 800 }*/
}

extension Segment {
    var kind: RulerKind { return .segment }
    
    func gap(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
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
                        return distance(point, ruler.arrow.at(offset: pos))
                    }
                }
                .flatMapError { _ in .success(distance(point, ruler.arrow.points.0)) }
        }
    }
    
    /*var touchPriority: CGFloat { return 900 }*/
}

// TODO: - Angle bisector, Perpendicular Bisector
