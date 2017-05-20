//
//  Transmitter.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import Result

// MARK: - Signal Propagation Algorithms

enum TransmitterSignalAlgorithm {
    case depthFirst
    case breadthFirst
}

// MARK: - Object That Propagates A Signal

protocol Transmitter: class {
    var receivers: [() -> Transmitter?] { get set }
}

extension Transmitter {

// MARK: - Send Signal
    
    private func sendToReceivers(algorithm: TransmitterSignalAlgorithm, customSignal: (Transmitter) -> Void) {
        for receiver in self.receivers {
            receiver()?.send(algorithm: algorithm, customSignal: customSignal)
        }
    }
    
    func send(algorithm: TransmitterSignalAlgorithm = .depthFirst, customSignal: (Transmitter) -> Void) {
        switch algorithm {
        case .breadthFirst:
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
            customSignal(self)
        case .depthFirst:
            customSignal(self)
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
        }
    }
    
// MARK: - Adding Receivers of Emitters
    
    func emitTo(_ receivers: [Transmitter]) {
        for receiver in receivers {
            self.receivers.append({ [weak receiver] in receiver })
        }
    }
    
    func emitTo(_ receiver: Transmitter) {
        receivers.append({ [weak receiver] in receiver })
    }
    
    func stopEmittingTo(_ receiver: Transmitter) {
        receivers = receivers.filter { $0() !== receiver }
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


