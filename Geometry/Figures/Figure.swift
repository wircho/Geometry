//
//  Figure.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure class

class Figure<T>: RawPropagator<Result<T, CGError>>, FigureProtocol {
    typealias FigureParents = SimpleTree<Weak<Propagator>>

// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    var parents: FigureParents
    
// MARK: - Initializers

    init () {
        parents = .empty
        super.init(initial: .inexistent)
    }
    
    init (_ parent: Propagator) {
        parents = FigureParents(parent)
        super.init(initial: .inexistent, parent: parent)
    }
    
    init (sorted parents: [Propagator]) {
        self.parents = FigureParents(sorted: parents)
        super.init(initial: .inexistent, parents: parents)
    }
    
    init (unsorted parents: [Propagator]) {
        self.parents = FigureParents(unsorted: parents)
        super.init(initial: .inexistent, parents: parents)
    }
    
// MARK: - Deinit
    
    deinit {
        gotSignal = true
    }
}

// MARK: - Figure Protocol

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
