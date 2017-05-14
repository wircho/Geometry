//
//  Figure.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure

protocol FigureBase: Transmitter { }

struct FigureStorage<Value> {
    var receivers: [Getter<Transmitter?>] = []
    var _result: Result<Value, MathError> = .failure(.none)
    var _needsRecalculation = true
}

protocol Figure: FigureBase, Recalculator {
    associatedtype Value
    var storage: FigureStorage<Value> { get set }
}

extension Figure {
    var receivers: [Getter<Transmitter?>] {
        get { return storage.receivers }
        set { storage.receivers = newValue }
    }
    
    var _result: Result<Value, MathError> {
        get { return storage._result }
        set { storage._result = newValue }
    }
    
    var _needsRecalculation: Bool {
        get { return storage._needsRecalculation }
        set { storage._needsRecalculation = newValue }
    }
    
    func appendToContext() {
        if let context = Association.getWeak(Thread.current, FigureContext.threadKey) as? FigureContext {
            context.append(self)
        }
    }
}

// TODO: Remove all this

//class Figure<Value>: RecalculationTransmitter<Result<Value, MathError>>, FigureProtocol {
//    
//// MARK: - Parents (For Comparison / Duplicate Prevention)
//    
//    typealias FigureParents = SimpleTree<Weak<Transmitter>>
//    var parents: FigureParents
//    
//// MARK: - Initializers
//
//    init () {
//        parents = .empty
//        super.init(.none)
//        checkFigureContext()
//    }
//    
//    init (_ parent: Transmitter) {
//        parents = FigureParents(parent)
//        super.init(.none, receiveFrom: [parent])
//        checkFigureContext()
//    }
//    
//    init (sorted parents: [Transmitter]) {
//        self.parents = FigureParents(sorted: parents)
//        super.init(.none, receiveFrom: parents)
//        checkFigureContext()
//    }
//    
//    init (unsorted parents: [Transmitter]) {
//        self.parents = FigureParents(unsorted: parents)
//        super.init(.none, receiveFrom: parents)
//        checkFigureContext()
//    }
//
//}
//
//// MARK: - Figure Protocol
//
//protocol FigureProtocol: Drawable {
//    associatedtype T
//    var result: Result<T, MathError> { get }
//}
//
//// MARK: - Getting Coalesced Raw Value From Weak/Optional
//
//extension WeakProtocol where T: FigureProtocol {
//    var coalescedValue: Result<T.T, MathError> {
//        return self.object?.result ?? .none
//    }
//}
//
//extension OptionalProtocol where W: FigureProtocol {
//    var coalescedValue: Result<W.T, MathError> {
//        return self.optionalCopy?.result ?? .none
//    }
//}
