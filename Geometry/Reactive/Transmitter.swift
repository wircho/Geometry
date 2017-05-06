//
//  Transmitter.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import Result

// MARK: - Class That Propagates A Boolean Signal

class Transmitter {
    
    private var _signal = true
    private var receivers: [Weak<Transmitter>] = []
    
// MARK: - Signal Status (get) And Propagation (set)
    
    var signal: Bool {
        get { return _signal }
        set {
            guard newValue != _signal else {
                return
            }
            _signal = newValue
            if newValue {
                receivers = receivers.filter { $0.object != nil }
                for receiver in receivers {
                    receiver.object?.signal = true
                }
            }
        }
    }
    
// MARK: - Initialization
    
    init(emitTo receivers: [Transmitter] = [], receiveFrom emitters: [Transmitter] = []) {
        emitTo(receivers)
        receiveFrom(emitters)
    }
    
// MARK: - Adding Receivers of Emitters
    
    func emitTo(_ receivers: [Transmitter]) {
        for receiver in receivers {
            self.receivers.append(Weak(receiver))
        }
    }
    
    func emitTo(_ receiver: Transmitter) {
        receivers.append(Weak(receiver))
    }
    
    func stopEmittingTo(_ receiver: Transmitter) {
        receivers = receivers.filter { $0.object !== receiver }
    }
    
    func receiveFrom(_ emitters: [Transmitter]) {
        for emitter in emitters {
            emitter.emitTo(self)
        }
    }
    
    func receiveFrom(_ emitter: Transmitter) {
        emitter.emitTo(self)
    }
    
    func stopReceivingFrom(_ emitter: Transmitter) {
        emitter.stopEmittingTo(self)
    }
    
}


