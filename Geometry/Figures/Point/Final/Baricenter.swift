//
//  Baricenter.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Baricenter: Figure, Point, ParentComparable {
    var pointStorage = PointStorage()
    
    let points: [Getter<Point?>]
    
    let parentOrder = ParentOrder.unsorted
    var parents: [AnyObject?] { return points.map { $0() } }
    
    init?(points: [Point]) {
        guard points.count >= 2 else { return nil }
        self.points = points.map { (point: Point) in { [weak point] in point } }
        setChildOf(points)
    }
    
    func recalculate() -> RawPointResult {
        var sum = RawPointResult.success(RawPoint.zero)
        for getter in points {
            guard let point = getter()?.result else { continue }
            sum += point
        }
        return sum / FloatResult.success(CGFloat(points.count))
    }
}
