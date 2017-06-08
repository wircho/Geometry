//
//  OneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
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
    
    var allTouchingPoints: [AnyFigure<P>] {
        return touchingDefiningPoints + intersectionPoints + slidingPoints
    }
    
    var touchingPointsSet: ObjectSet<AnyObject> {
        return ObjectSet<AnyObject>(allTouchingPoints.map { $0.figure })
    }
    
    func findCommonPoints<Other: OneDimensional>(with other: Other, _ closure: (AnyFigure<P>) -> Bool) {
        let array = allTouchingPoints
        let otherSet = other.touchingPointsSet
        for p in array {
            if otherSet.contains(p.figure) {
                guard closure(p) else { break }
            }
        }
    }
}

extension OneDimensional where Self: StrokeAppears, Self: FigureBase {
    func gapToBorder(from cgPoint: CGPoint) -> Res<CGFloat> {
        let point = cgPoint as! P
        return gap(from: point).map {
            (gap: P.Value) -> CGFloat in
            let cgGap = gap as! CGFloat
            guard let context = context, cgGap < appearance.lineWidth / 2 else { return cgGap }
            return min(cgGap, context.maxSolidDistance)
        }
    }
}
