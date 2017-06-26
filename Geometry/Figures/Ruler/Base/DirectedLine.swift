//
//  DirectedLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

protocol DirectedLine: Line, ParentComparable {
    associatedtype R: RawRulerProtocol
    var directedLineStorage: DirectedLineStorage<R> { get set }
    func calculateArrowDirection() -> Res<R.Arrow.Point>
    init(_ directedLineStorage: DirectedLineStorage<R>)
}

extension DirectedLine {
    func calculateArrow() -> Res<R.Arrow> {
        let p = point.result ?? .none
        return Res<R.Arrow>(points: (p, p + calculateArrowDirection()))
    }
    
    var touchingDefiningPoints: [AnyFigure<R.Arrow.Point>] {
        return [point].flatMap { $0.anyFigure }
    }
    
    func at(offset: R.Arrow.Point.Value) -> Res<R.Arrow.Point> {
        return result.flatMap {
            value in
            normReciprocal.map {
                normReciprocal in
                value.arrow.at(offset: offset * normReciprocal)
            }
        }
    }
    
    func nearestOffset(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        return result.arrow.projectIso(point)
    }
    
    var parentOrder: ParentOrder { return .sorted }
    var parents: [AnyObject?] { return [point.figure, ruler.figure] }
    
    var rulerStorage: RulerStorage<R> {
        get { return directedLineStorage.rulerStorage }
        set { directedLineStorage.rulerStorage = newValue }
    }
    
    var point: AnyWeakFigure<R.Arrow.Point> { return directedLineStorage.point }
    var ruler: AnyWeakFigure<R> { return directedLineStorage.ruler }
}

extension DirectedLine where Self: Figure {
    init<T: Point, S: Ruler>(_ p: T, _ r: S) where T.ResultValue == Res<R.Arrow.Point>, S.ResultValue == Res<R>  {
        self.init(DirectedLineStorage(p, r))
        setChildOf([p, r])
    }
}

struct DirectedLineStorage<R: RawRulerProtocol> {
    var rulerStorage = RulerStorage<R>()
    
    var point: AnyWeakFigure<R.Arrow.Point>
    var ruler: AnyWeakFigure<R>
    
    init<T: Point, S: Ruler>(_ p: T, _ r: S) where T.ResultValue == Res<R.Arrow.Point>, S.ResultValue == Res<R> {
        point = AnyWeakFigure(p)
        ruler = AnyWeakFigure(r)
    }
}
