//
//  RawPropagator.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol RawPropagator: RawCache, Propagator { }

extension RawPropagator {
    var raw: Raw {
        guard gotSignal else {
            return _raw
        }
        _raw = getRaw()
        gotSignal = false
        return _raw
    }
}
