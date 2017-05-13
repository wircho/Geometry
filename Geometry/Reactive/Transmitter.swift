//
//  Transmitter.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import Result

// MARK: - Class That Propagates A Signal

class Transmitter {
    
    private var receivers: [Weak<Transmitter>] = []
    
// MARK: - Send Signal
    
    enum CustomSignalAlgorithm {
        case depthFirst
        case breadthFirst
    }
    
    private func sendToReceivers(algorithm: CustomSignalAlgorithm, customSignal: (Transmitter) -> Void) {
        for receiver in self.receivers {
            receiver.object?.send(algorithm: algorithm, customSignal: customSignal)
        }
    }
    
    func send(algorithm: CustomSignalAlgorithm = .depthFirst, customSignal: (Transmitter) -> Void) {
        switch algorithm {
        case .breadthFirst:
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
            customSignal(self)
        case .depthFirst:
            customSignal(self)
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
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


