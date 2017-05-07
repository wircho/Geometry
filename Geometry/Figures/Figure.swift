//
//  Figure.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure class

class Figure<T>: RecalculationTransmitter<Result<T, MathError>>, FigureProtocol {
    
// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    typealias FigureParents = SimpleTree<Weak<Transmitter>>
    var parents: FigureParents
    
// MARK: - Initializers

    init () {
        parents = .empty
        super.init(value: .none)
    }
    
    init (_ parent: Transmitter) {
        parents = FigureParents(parent)
        super.init(value: .none, receiveFrom: [parent])
    }
    
    init (sorted parents: [Transmitter]) {
        self.parents = FigureParents(sorted: parents)
        super.init(value: .none, receiveFrom: parents)
    }
    
    init (unsorted parents: [Transmitter]) {
        self.parents = FigureParents(unsorted: parents)
        super.init(value: .none, receiveFrom: parents)
    }
    
// MARK: - Deinit
    
    deinit {
        signal = true
    }
}

// MARK: - Figure Protocol

protocol FigureProtocol {
    associatedtype T
    var value: Result<T, MathError> { get }
}

// MARK: - Getting Coalesced Raw Value From Weak/Optional

extension WeakProtocol where T: FigureProtocol {
    var coalescedValue: Result<T.T, MathError> {
        return self.object?.value ?? .none
    }
}

extension OptionalProtocol where W: FigureProtocol {
    var coalescedValue: Result<W.T, MathError> {
        return self.optionalCopy?.value ?? .none
    }
}
