//
//  Ruler2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Ruler Figures Through 2 Points

protocol Ruler2Points: Ruler, ParentComparable {
    var ruler2PointsStorage: Ruler2PointsStorage<R> { get set }
    init(_ ruler2PointsStorage: Ruler2PointsStorage<R>)
}

extension Ruler2Points {
    var parents: [AnyObject?] { return [point0.figure, point1.figure] }
    
    var rulerStorage: RulerStorage<R> {
        get { return  ruler2PointsStorage.rulerStorage }
        set { ruler2PointsStorage.rulerStorage = newValue }
    }
    
    var point0: AnyWeakFigure<R.Arrow.Point> { return ruler2PointsStorage.point0 }
    var point1: AnyWeakFigure<R.Arrow.Point> { return ruler2PointsStorage.point1 }
}

protocol Ruler2PointsStandard: Ruler2Points { }

extension Ruler2PointsStandard {
    func calculateArrow() -> Res<R.Arrow> {
        let p0 = point0.result ?? .none
        let p1 = point1.result ?? .none
        return Res<R.Arrow>(points: (p0, p1))
    }
    
    var touchingDefiningPoints: [AnyFigure<R.Arrow.Point>] {
        return [point0, point1].flatMap { $0.anyFigure }
    }
}

extension Ruler2Points where Self: Figure {
    init<T0: Point, T1: Point>(_ p0: T0, _ p1: T1) where T0.ResultValue == Res<R.Arrow.Point>, T1.ResultValue == Res<R.Arrow.Point> {
        self.init(Ruler2PointsStorage(p0, p1))
        setChildOf([p0, p1])
    }
}

struct Ruler2PointsStorage<R: RawRulerProtocol> {
    var rulerStorage = RulerStorage<R>()
    
    var point0 = AnyWeakFigure<R.Arrow.Point>()
    var point1 = AnyWeakFigure<R.Arrow.Point>()
    
    init<T0: Point, T1: Point>(_ p0: T0, _ p1: T1) where T0.ResultValue == Res<R.Arrow.Point>, T1.ResultValue == Res<R.Arrow.Point> {
        point0 = AnyWeakFigure<R.Arrow.Point>(p0)
        point1 = AnyWeakFigure<R.Arrow.Point>(p1)
    }
}
