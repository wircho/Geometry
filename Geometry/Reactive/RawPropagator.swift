//
//  RawPropagator.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

class RawPropagator<Raw>: SignalPropagator {
    
// MARK: - Raw Value
    
    private var _raw: Raw
    
// MARK: - Initialization
    
    init(initial: Raw, emitTo receivers:[SignalPropagator] = [], receiveFrom emitters:[SignalPropagator] = []) {
        _raw = initial
        super.init(emitTo: receivers, receiveFrom: emitters)
    }
    
// MARK: - Recalculate Raw If Signal
    
    func getRaw() -> Raw {
        fatalError("\(#function) must be overriden")
    }
    
    var raw: Raw {
        guard signal else {
            return _raw
        }
        _raw = getRaw()
        signal = false
        return _raw
    }
}
