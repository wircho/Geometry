//
//  SlidingPoint.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-12.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class SlidingPoint<P: RawPointProtocol>: Point, FreeValued {
    var pointStorage = PointStorage<P>()
    var _freeValue: P.Value
    
    var floor: AnyWeakOneDimensional<P>
    
    init<F: OneDimensional>(_ floor: F, at initial: P.Value) where F.P == P {
        self.floor = AnyWeakOneDimensional(floor)
        _freeValue = initial
        floor.slidingPoints.append(AnyFigure(self))
        setChildOf([floor])
    }
    
    func recalculate() -> Res<P> {
        return floor.atOffset(freeValue) ?? .none
    }
    
    func nearestFreeValue(from point: P) -> Res<P.Value> {
        return floor.nearestOffsetFrom(point) ?? .none
    }
}
