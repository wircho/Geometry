//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

final class FreePoint<P: RawPointProtocol>: Point, FreeValued {
    var pointStorage = PointStorage<P>()
    var _freeValue: P
    
    init(at initial: P, `in` context: FigureContext) {
        _freeValue = initial
        context.append(self)
    }
    
    convenience init(x: P.Value, y: P.Value, `in` context: FigureContext) {
        self.init(at: P(x: x, y: y), in: context)
    }
    
    func nearestFreeValue(from point: P) -> Res<P> {
        return .success(point)
    }
}
