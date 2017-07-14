//
//  LazyNode.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

// MARK: - Signal Propagation Algorithms

enum LazyNodeSignalAlgorithm {
    case depthFirst
    case breadthFirst
}

// MARK: - Object That Propagates A Signal

protocol LazyNodeBase: class {
    var receivers: [() -> LazyNodeBase?] { get set }
    var _needsUpdate: Bool { get set }
    func send(algorithm: LazyNodeSignalAlgorithm, customSignal: (LazyNodeBase) -> Void)
    func send(customSignal: (LazyNodeBase) -> Void)
    func emit(to receivers: [LazyNodeBase])
    func emit(to receiver: LazyNodeBase)
    func stopEmitting(to receiver: LazyNodeBase)
    func receive(from emitters: [LazyNodeBase])
    func receive(from emitter: LazyNodeBase)
    func stopReceiving(from emitter: LazyNodeBase)
}

protocol LazyNode: LazyNodeBase {
    associatedtype ResultValue
    var _result: ResultValue { get set }
    func update() -> ResultValue
}

// MARK: - Send Signals

extension LazyNode {
    private func sendToReceivers(algorithm: LazyNodeSignalAlgorithm, customSignal: (LazyNodeBase) -> Void) {
        for receiver in self.receivers {
            receiver()?.send(algorithm: algorithm, customSignal: customSignal)
        }
    }
    
    func send(customSignal: (LazyNodeBase) -> Void) {
        send(algorithm: .depthFirst, customSignal: customSignal)
    }
    
    func send(algorithm: LazyNodeSignalAlgorithm, customSignal: (LazyNodeBase) -> Void) {
        switch algorithm {
        case .breadthFirst:
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
            customSignal(self)
        case .depthFirst:
            customSignal(self)
            sendToReceivers(algorithm: algorithm, customSignal: customSignal)
        }
    }
}

// MARK: - Adding Receivers/Emitters

extension LazyNode {
    func emit(to receivers: [LazyNodeBase]) {
        for receiver in receivers {
            self.receivers.append({ [weak receiver] in receiver })
        }
    }
    
    func emit(to receiver: LazyNodeBase) {
        receivers.append({ [weak receiver] in receiver })
    }
    
    func stopEmitting(to receiver: LazyNodeBase) {
        receivers = receivers.filter { $0() !== receiver }
    }
    
    func receive(from emitters: [LazyNodeBase]) {
        for emitter in emitters {
            emitter.emit(to: self)
        }
    }
    
    func receive(from emitter: LazyNodeBase) {
        emitter.emit(to: self)
    }
    
    func stopReceiving(from emitter: LazyNodeBase) {
        emitter.stopEmitting(to: self)
    }
}

// MARK: - Result Updates

extension LazyNode {
    var needsUpdate: Bool {
        get {
            return _needsUpdate
        }
        set {
            guard newValue != _needsUpdate else { return }
            if newValue {
                send { $0._needsUpdate = true }
            } else {
                _needsUpdate = false
            }
        }
    }
    
    var result: ResultValue {
        guard needsUpdate else {
            return _result
        }
        _result = update()
        needsUpdate = false
        return _result
    }
}


