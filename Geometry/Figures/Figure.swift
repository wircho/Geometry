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
    
// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    typealias FigureParents = SimpleTree<Weak<SignalPropagator>>
    var parents: FigureParents
    
// MARK: - Initializers

    init () {
        parents = .empty
        super.init(initial: .inexistent)
    }
    
    init (_ parent: SignalPropagator) {
        parents = FigureParents(parent)
        super.init(initial: .inexistent, receiveFrom: [parent])
    }
    
    init (sorted parents: [SignalPropagator]) {
        self.parents = FigureParents(sorted: parents)
        super.init(initial: .inexistent, receiveFrom: parents)
    }
    
    init (unsorted parents: [SignalPropagator]) {
        self.parents = FigureParents(unsorted: parents)
        super.init(initial: .inexistent, receiveFrom: parents)
    }
    
// MARK: - Deinit
    
    deinit {
        signal = true
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
