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
    func compare(with other: Self) -> Bool
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
