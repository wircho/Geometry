//
//  Figure.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure class

class Figure<T>: Propagator, FigureProtocol {
    typealias FigureParents = SimpleTree<Weak<Propagator>>

// MARK: - RawPropagator Conformance

    var _raw = Result<T, CGError>.inexistent
    func getRaw() -> Result<T, CGError> {
        fatalError("\(#function) must be overriden")
    }
    
// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    var parents: FigureParents
    
// MARK: - Initializers

    override init () {
        parents = .empty
        super.init()
    }
    
    init (_ parent: Propagator) {
        parents = FigureParents(parent)
        super.init()
        receiveFrom(parent)
    }
    
    init (sorted figures: [Propagator]) {
        parents = FigureParents(sorted: figures)
        super.init()
        receiveFrom(figures)
    }
    
    init (unsorted figures: [Propagator]) {
        parents = FigureParents(unsorted: figures)
        super.init()
        receiveFrom(figures)
    }
    
// MARK: - Deinit
    
    deinit {
        gotSignal = true
    }
}

// MARK: - Figure Protocol

protocol FigureProtocol: RawPropagatorProtocol {
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
