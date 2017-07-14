//
//  OneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol OneDimensional: Figure {
    associatedtype MemberPoint: RawPointProtocol
    var oneDimensionalStorage: OneDimensionalStorage<MemberPoint> { get set }
    var touchingDefiningPoints: [AnyFigure<MemberPoint>] { get }
    func at(offset: MemberPoint.Value) -> MemberPoint?
    func nearestOffset(from point: MemberPoint) -> MemberPoint.Value?
    func gap(from point: MemberPoint) -> MemberPoint.Value?
}

struct OneDimensionalStorage<P: RawPointProtocol> {
    var weakSlidingPoints: [AnyWeakFigure<P>] = []
    var weakIntersectionPoints: [AnyWeakFigure<P>] = []
}

private extension ObjectSet where T == AnyObject {
    init<S>(figures: [AnyFigure<S>]) {
        self.init(figures.map { $0.figure })
    }
}

extension OneDimensional {
    var slidingPoints: [AnyFigure<MemberPoint>] {
        get {
            oneDimensionalStorage.weakSlidingPoints = oneDimensionalStorage.weakSlidingPoints.filter { $0.figure != nil }
            return oneDimensionalStorage.weakSlidingPoints.flatMap { $0.anyFigure }
        }
        set {
            oneDimensionalStorage.weakSlidingPoints = newValue.map { $0.anyWeakFigure }
        }
    }
    
    var intersectionPoints: [AnyFigure<MemberPoint>] {
        get {
            oneDimensionalStorage.weakIntersectionPoints = oneDimensionalStorage.weakIntersectionPoints.filter { $0.figure != nil }
            return oneDimensionalStorage.weakIntersectionPoints.flatMap { $0.anyFigure }
        }
        set {
            oneDimensionalStorage.weakIntersectionPoints = newValue.map { $0.anyWeakFigure }
        }
    }
    
    var nonIntersectionTouchingPoints: [AnyFigure<MemberPoint>] {
        return touchingDefiningPoints + slidingPoints
    }
    
    var allTouchingPoints: [AnyFigure<MemberPoint>] {
        return nonIntersectionTouchingPoints + intersectionPoints
    }
    
    func findPreexistingCommonPoints<Other: OneDimensional>(with other: Other, _ closure: (AnyFigure<MemberPoint>) -> Bool) {
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
            guard otherNonIntersections.contains(p.figure) else { continue }
            guard closure(p) else { break }
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
