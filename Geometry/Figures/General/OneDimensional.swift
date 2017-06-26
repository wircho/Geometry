//
//  OneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

protocol OneDimensional: Figure {
    associatedtype P: RawPointProtocol
    var oneDimensionalStorage: OneDimensionalStorage<P> { get set }
    var touchingDefiningPoints: [AnyFigure<P>] { get }
    func at(offset: P.Value) -> Res<P>
    func nearestOffset(from point: P) -> Res<P.Value>
    func gap(from point: P) -> Res<P.Value>
}

struct OneDimensionalStorage<P: RawPointProtocol> {
    var weakSlidingPoints: [AnyWeakFigure<P>] = []
    var weakIntersectionPoints: [AnyWeakFigure<P>] = []
}

private extension ObjectSet where T == AnyObject {
    init<T>(figures: [AnyFigure<T>]) {
        self.init(figures.map { $0.figure })
    }
}

extension OneDimensional {
    var slidingPoints: [AnyFigure<P>] {
        get {
            oneDimensionalStorage.weakSlidingPoints = oneDimensionalStorage.weakSlidingPoints.filter { $0.figure != nil }
            return oneDimensionalStorage.weakSlidingPoints.flatMap { $0.anyFigure }
        }
        set {
            oneDimensionalStorage.weakSlidingPoints = newValue.map { $0.anyWeakFigure }
        }
    }
    
    var intersectionPoints: [AnyFigure<P>] {
        get {
            oneDimensionalStorage.weakIntersectionPoints = oneDimensionalStorage.weakIntersectionPoints.filter { $0.figure != nil }
            return oneDimensionalStorage.weakIntersectionPoints.flatMap { $0.anyFigure }
        }
        set {
            oneDimensionalStorage.weakIntersectionPoints = newValue.map { $0.anyWeakFigure }
        }
    }
    
    var nonIntersectionTouchingPoints: [AnyFigure<P>] {
        return touchingDefiningPoints + slidingPoints
    }
    
    var allTouchingPoints: [AnyFigure<P>] {
        return nonIntersectionTouchingPoints + intersectionPoints
    }
    
    func findPreexistingCommonPoints<Other: OneDimensional>(with other: Other, _ closure: (AnyFigure<P>) -> Bool) {
        let intersections = intersectionPoints
        let nonIntersections = nonIntersectionTouchingPoints
        let otherAll = ObjectSet(figures: other.allTouchingPoints)
        let otherNonIntersections = ObjectSet(figures: other.nonIntersectionTouchingPoints)
        for p in nonIntersections {
            if otherAll.contains(p.figure) {
                guard closure(p) else { break }
            }
        }
        for p in intersections {
            if otherNonIntersections.contains(p.figure) {
                guard closure(p) else { break }
            }
        }
    }
}

/*
extension OneDimensional where Self: StrokeAppears, Self: FigureBase {
    func gap(from point: RawPoint) -> Res<CGFloat> {
        return gapToCenter(from: point).map {
            gap in
            guard let context = context, gap < appearance.lineWidth / 2 else { return gap }
            return min(gap, context.maxSolidDistance)
        }
    }
}
*/
