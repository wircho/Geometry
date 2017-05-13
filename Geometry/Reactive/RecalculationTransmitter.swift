//
//  RecalculationTransmitter.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: - Base Class

class _RecalculationTransmitter: Transmitter {
    
// MARK: - Needs Recalculation
    
    private var _needsRecalculation: Bool = true
    
    var needsRecalculation: Bool {
        get {
            return _needsRecalculation
        }
        set {
            guard newValue != _needsRecalculation else {
                return
            }
            if newValue {
                send { transmitter in
                    if let r = transmitter as? _RecalculationTransmitter {
                        r._needsRecalculation = true
                    }
                }
            } else {
                _needsRecalculation = false
            }
        }
    }
}

// MARK: - Main Class

class RecalculationTransmitter<Result>: _RecalculationTransmitter {
    
// MARK: - Raw Result
    
    private var _result: Result
    
// MARK: - Initialization
    
    init(_ result: Result, emitTo receivers:[Transmitter] = [], receiveFrom emitters:[Transmitter] = []) {
        _result = result
        super.init(emitTo: receivers, receiveFrom: emitters)
    }
    
// MARK: - Recalculate Value If Signal
    
    func recalculate() -> Result {
        fatalError("\(#function) must be overriden")
    }
    
    var result: Result {
        guard needsRecalculation else {
            return _result
        }
        _result = recalculate()
        needsRecalculation = false
        return _result
    }
}
