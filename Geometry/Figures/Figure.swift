//
//  Figure.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: -

class Figure<T>: FigureProtocol, RawPropagator {
    typealias FigureParents = SimpleTree<Weak<AnyObject>>

// MARK: - Reactive Model: RawPropagator (RawCache + Propagator) Conformance

    var _raw = Result<T, CGError>.inexistent
    var _gotSignal = true
    var receivers: [OptionalClosureGetter] = []
    
    func getRaw() -> Result<T, CGError> {
        fatalError("\(#function) must be overriden")
    }
    
// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    var parents: FigureParents
    
// MARK: - Initializers
    
    init () {
        self.parents = .empty
    }
    
    init (_ value: Propagator) {
        self.parents = FigureParents(value)
        value.addReceiver(self)
    }
    
    init (_ value0: Propagator, _ value1: Propagator) {
        self.parents = FigureParents(value0, value1)
        value0.addReceiver(self)
        value1.addReceiver(self)
    }
    
    init (_ value0: Propagator, _ value1: Propagator, _ value2: Propagator) {
        self.parents = FigureParents(value0, value1, value2)
        value0.addReceiver(self)
        value1.addReceiver(self)
        value2.addReceiver(self)
    }
    
    init (unsorted value0: Propagator, _ value1: Propagator) {
        self.parents = FigureParents(unsorted: value0, value1)
        value0.addReceiver(self)
        value1.addReceiver(self)
    }
    
    init (unsorted value0: Propagator, _ value1: Propagator, _ value2: Propagator) {
        self.parents = FigureParents(unsorted: value0, value1, value2)
        value0.addReceiver(self)
        value1.addReceiver(self)
        value2.addReceiver(self)
    }
    
    init (_ array: [Propagator]) {
        self.parents = FigureParents(array)
        for value in array {
            value.addReceiver(self)
        }
    }
    
    init (sorted array: [Propagator]) {
        self.parents = FigureParents(array)
        for value in array {
            value.addReceiver(self)
        }
    }
    
    init (unsorted array: [Propagator]) {
        self.parents = FigureParents(unsorted: array)
        for value in array {
            value.addReceiver(self)
        }
    }
    
// MARK: - Deinit
    
    deinit {
        gotSignal = true
    }
}

// MARK: - FigureProtocol

protocol FigureProtocol {
    associatedtype T
    var raw: Result<T, CGError> { get }
}

// MARK: - Getting Defaulted Raw Value From Weak/Optional

extension WeakProtocol where T: FigureProtocol {
    var defaultedRaw: Result<T.T, CGError> {
        return self.object?.raw ?? .inexistent
    }
}

extension OptionalProtocol where W: FigureProtocol {
    var defaultedRaw: Result<W.T, CGError> {
        return self.optionalCopy?.raw ?? .inexistent
    }
}
