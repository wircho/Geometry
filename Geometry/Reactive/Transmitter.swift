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
    
    func emit(to receivers: [Transmitter]) {
        for receiver in receivers {
            self.receivers.append({ [weak receiver] in receiver })
        }
    }
    
    func emit(to receiver: Transmitter) {
        receivers.append({ [weak receiver] in receiver })
    }
    
    func stopEmitting(to receiver: Transmitter) {
        receivers = receivers.filter { $0() !== receiver }
    }
    
    func receive(from emitters: [Transmitter]) {
        for emitter in emitters {
            emitter.emit(to: self)
        }
    }
    
    func receive(from emitter: Transmitter) {
        emitter.emit(to: self)
    }
    
    func stopReceiving(from emitter: Transmitter) {
        emitter.stopEmitting(to: self)
    }
    
}


