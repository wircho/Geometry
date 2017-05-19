//
//  DirectedLine.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol DirectedLine: Ruler, Line, ParentComparable {
    var directedLineStorage: DirectedLineStorage { get set }
    func calculateArrowDirection() -> RawPointResult
    init(_ directedLineStorage: DirectedLineStorage)
}

extension DirectedLine {
    func calculateArrow() -> ArrowResult {
        let p = point?.result ?? .none
        return ArrowResult(points: (p, p + calculateArrowDirection()))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point].flatMap { $0 }
    }
    
    func at(_ pos: CGFloat) -> RawPointResult {
        return result.flatMap {
            value in
            normReciprocal.map {
                normReciprocal in
                value.arrow.at(pos * normReciprocal)
            }
        }
    }
    
    func nearest(from point: RawPoint) -> FloatResult {
        return result.arrow.projectIso(point)
    }
    
    var parentOrder: ParentOrder { return .sorted }
    var parents: [AnyObject?] { return [point, ruler] }
    
    var rulerStorage: RulerStorage {
        get { return directedLineStorage.rulerStorage }
        set { directedLineStorage.rulerStorage = newValue }
    }
    
    var point: Point? { return directedLineStorage.point }
    var ruler: Ruler? { return directedLineStorage.ruler }
}

extension DirectedLine where Self: Figure {
    init(_ p: Point, _ r: Ruler) {
        self.init(DirectedLineStorage(p, r))
        setChildOf([p, r])
    }
}

struct DirectedLineStorage {
    var rulerStorage = RulerStorage()
    
    weak var point: Point?
    weak var ruler: Ruler?
    
    init(_ p: Point, _ r: Ruler) {
        point = p
        ruler = r
    }
}
