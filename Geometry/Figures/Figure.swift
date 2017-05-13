//
//  Figure.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure class

class Figure<Value>: RecalculationTransmitter<Result<Value, MathError>>, FigureProtocol {
    
// MARK: - Parents (For Comparison / Duplicate Prevention)
    
    typealias FigureParents = SimpleTree<Weak<Transmitter>>
    var parents: FigureParents
    
// MARK: - Initializers

    init () {
        parents = .empty
        super.init(.none)
        checkFigureContext()
    }
    
    init (_ parent: Transmitter) {
        parents = FigureParents(parent)
        super.init(.none, receiveFrom: [parent])
        checkFigureContext()
    }
    
    init (sorted parents: [Transmitter]) {
        self.parents = FigureParents(sorted: parents)
        super.init(.none, receiveFrom: parents)
        checkFigureContext()
    }
    
    init (unsorted parents: [Transmitter]) {
        self.parents = FigureParents(unsorted: parents)
        super.init(.none, receiveFrom: parents)
        checkFigureContext()
    }
    
// MARK: - Drawable
    
    func drawIn(_ rect: CGRect) {
        fatalError("\(#function) must be overriden")
    }
    
// MARK: - Figure Context
    
    private func checkFigureContext() {
        if let context = Association.getWeak(Thread.current, FigureContext.threadKey) as? FigureContext {
            context.append(self)
        }
    }
    
// MARK: - Deinit
    
    deinit {
        needsRecalculation = true
    }
}

// MARK: - Figure Protocol

protocol FigureProtocol: Drawable {
    associatedtype T
    var result: Result<T, MathError> { get }
}

// MARK: - Getting Coalesced Raw Value From Weak/Optional

extension WeakProtocol where T: FigureProtocol {
    var coalescedValue: Result<T.T, MathError> {
        return self.object?.result ?? .none
    }
}

extension OptionalProtocol where W: FigureProtocol {
    var coalescedValue: Result<W.T, MathError> {
        return self.optionalCopy?.result ?? .none
    }
}
