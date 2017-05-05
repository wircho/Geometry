//
//  Propagator.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import Result

typealias Closure = ()->Void
typealias OptionalClosureGetter = Getter<Closure?>

protocol Propagator: class {
    var _gotSignal: Bool { get set }
    var receivers: [OptionalClosureGetter] { get set }
}

extension Propagator {
    private func receiveSignal() {
        gotSignal = true
    }
    
    var gotSignal: Bool {
        get { return _gotSignal }
        set {
            guard newValue != _gotSignal else {
                return
            }
            _gotSignal = newValue
            if newValue {
                receivers = receivers.filter { $0.value != nil }
                for receiver in receivers {
                    receiver.value?()
                }
            }
        }
    }
    
    func addReceiver(_ receiver: Propagator) {
        receivers.append(
            Getter {
                [weak receiver] in
                guard let receiver = receiver else { return nil }
                return receiver.receiveSignal
            }
        )
    }
}
