//
//  FreeScalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class FreeScalar<P: RawPointProtocol>: Scalar, FreeValued {
    var storage = FigureStorage<P.Value>()
    var _freeValue: P.Value
    
    init(at initial: P.Value, `in` context: FigureContext) {
        _freeValue = initial
        context.append(self)
    }
    
    func nearestFreeValue(from point: P) -> Res<P.Value> {
        return .none
    }
}
