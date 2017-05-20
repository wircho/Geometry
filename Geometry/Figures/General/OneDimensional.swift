//
//  OneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol OneDimensional: FigureBase {
//    func intersectionPointsNotWith(other: Transmitter?) -> [Point]
    var oneDimensionalStorage: OneDimensionalStorage { get set }
    var touchingDefiningPoints: [Point] { get }
    func at(_ pos: CGFloat) -> Res<RawPoint>
    func nearest(from point: RawPoint) -> Res<CGFloat>
    func gapToCenter(from point: RawPoint) -> Res<CGFloat>
}

struct OneDimensionalStorage {
    var slidingPointGetters: [Getter<Point?>] = []
    var intersectionPointGetters: [Getter<Point?>] = []
}

extension OneDimensional {
    var slidingPoints: [Point] {
        get {
            oneDimensionalStorage.slidingPointGetters = oneDimensionalStorage.slidingPointGetters.filter { $0() != nil }
            return oneDimensionalStorage.slidingPointGetters.flatMap { $0() }
        }
        set {
            oneDimensionalStorage.slidingPointGetters = newValue.map { (point: Point) in return { [weak point] in point } }
        }
    }
    
    var intersectionPoints: [Point] {
        get {
            oneDimensionalStorage.intersectionPointGetters = oneDimensionalStorage.intersectionPointGetters.filter { $0() != nil }
            return oneDimensionalStorage.intersectionPointGetters.flatMap { $0() }
        }
        set {
            oneDimensionalStorage.intersectionPointGetters = newValue.map { (point: Point) in return { [weak point] in point } }
        }
    }
    
    var allTouchingPoints: [Point] {
        return touchingDefiningPoints + intersectionPoints + slidingPoints
    }
    
    var touchingPointsSet: ObjectSet<AnyObject> {
        return ObjectSet<AnyObject>(allTouchingPoints as [AnyObject])
    }
    
    func findCommonPoints(with other: OneDimensional, _ closure: (Point) -> Bool) {
        let array = allTouchingPoints
        let otherSet = other.touchingPointsSet
        for p in array {
            if otherSet.contains(p) {
                guard closure(p) else { break }
            }
        }
    }
}

extension OneDimensional where Self: StrokeAppears, Self: FigureBase {
    func gap(from point: RawPoint) -> Res<CGFloat> {
        return gapToCenter(from: point).map {
            gap in
            guard let context = context, gap < appearance.lineWidth / 2 else { return gap }
            return min(gap, context.maxSolidDistance)
        }
    }
}
