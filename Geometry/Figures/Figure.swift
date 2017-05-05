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
        parents = .empty
    }
    
    init (_ parent: Propagator) {
        parents = FigureParents(parent)
        receiveFrom(parent)
    }
    
    init (sorted figures: [Propagator]) {
        parents = FigureParents(sorted: figures)
        receiveFrom(figures)
    }
    
    init (unsorted figures: [Propagator]) {
        parents = FigureParents(unsorted: figures)
        receiveFrom(figures)
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
