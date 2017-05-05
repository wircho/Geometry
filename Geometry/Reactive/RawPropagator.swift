//
//  RawPropagator.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

class RawPropagator<Raw>: Propagator {
    var _raw: Raw
    
    init(initial: Raw, parents:[Propagator] = []) {
        _raw = initial
        super.init()
        receiveFrom(parents)
    }
    
    init(initial: Raw, parent:Propagator) {
        _raw = initial
        super.init()
        receiveFrom(parent)
    }
    
    func getRaw() -> Raw {
        fatalError("\(#function) must be overriden")
    }
    
    var raw: Raw {
        guard gotSignal else {
            return _raw
        }
        _raw = getRaw()
        gotSignal = false
        return _raw
    }
}
