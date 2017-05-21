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
    var ruler2PointsStorage: Ruler2PointsStorage { get set }
    init(_ ruler2PointsStorage: Ruler2PointsStorage)
}

extension Ruler2Points {
    var parents: [AnyObject?] { return [point0, point1] }
    
    var rulerStorage: RulerStorage {
        get { return  ruler2PointsStorage.rulerStorage }
        set { ruler2PointsStorage.rulerStorage = newValue }
    }
    
    var point0: Point? { return ruler2PointsStorage.point0 }
    
    var point1: Point? { return ruler2PointsStorage.point1 }
}

protocol Ruler2PointsStandard: Ruler2Points { }

extension Ruler2PointsStandard {
    func calculateArrow() -> Res<Arrow> {
        let p0 = point0?.result ?? .none
        let p1 = point1?.result ?? .none
        return Res<Arrow>(points: (p0, p1))
    }
    
    var touchingDefiningPoints: [Point] {
        return [point0, point1].flatMap { $0 }
    }
}

extension Ruler2Points where Self: Figure {
    init(_ p0: Point, _ p1: Point) {
        self.init(Ruler2PointsStorage(p0, p1))
        setChildOf([p0, p1])
    }
}

struct Ruler2PointsStorage {
    var rulerStorage = RulerStorage()
    
    weak var point0: Point? = nil
    weak var point1: Point? = nil
    
    init(_ p0: Point, _ p1: Point) {
        point0 = p0
        point1 = p1
    }
}
