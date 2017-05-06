//
//  RecalculationSignalPropagator.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

class RecalculationSignalPropagator<Value>: SignalPropagator {
    
// MARK: - Raw Value
    
    private var _value: Value
    
// MARK: - Initialization
    
    init(value: Value, emitTo receivers:[SignalPropagator] = [], receiveFrom emitters:[SignalPropagator] = []) {
        _value = value
        super.init(emitTo: receivers, receiveFrom: emitters)
    }
    
// MARK: - Recalculate Value If Signal
    
    func recalculate() -> Value {
        fatalError("\(#function) must be overriden")
    }
    
    var value: Value {
        guard signal else {
            return _value
        }
        _value = recalculate()
        signal = false
        return _value
    }
}
