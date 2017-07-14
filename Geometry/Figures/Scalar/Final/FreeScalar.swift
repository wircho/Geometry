//
//  FreeScalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

final class FreeScalar<P: RawPointProtocol>: Scalar, FreeValued {
    typealias FreeValue = P.Value
    typealias FreeValuePoint = P
    
    var storage = FigureStorage<P.Value>()
    var _freeValue: P.Value = 5

    init(at initial: P.Value, `in` context: FigureContext) {
        _freeValue = initial
        context.append(self)
    }
    
    func nearestFreeValue(from point: P) -> P.Value? {
        return nil
    }
}
