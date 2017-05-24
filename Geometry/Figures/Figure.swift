//
//  Figure.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure

protocol FigureBase: Transmitter {
    var context: FigureContext? { get set }
    var selected: Bool { get set }
}

struct FigureStorage<Value> {
    weak var context: FigureContext?
    var receivers: [() -> Transmitter?] = []
    var _result: Result<Value, MathError> = .failure(.none) {
        didSet {
            if case .success = oldValue, case .failure = _result, selected {
                selected = false
            }
        }
    }
    var _needsRecalculation = true {
        didSet {
            if _needsRecalculation && !oldValue {
                context?.setFiguresWillRecalculate()
            }
        }
    }
    var selected = false {
        didSet {
            if selected != oldValue {
                context?.setFiguresWillRecalculate()
            }
        }
    }
}

protocol Figure: FigureBase, Recalculator {
    associatedtype Value
    var storage: FigureStorage<Value> { get set }
    func compare(with other: Self) -> Bool
}

extension Figure {
    var receivers: [() -> Transmitter?] {
        get { return storage.receivers }
        set { storage.receivers = newValue }
    }
    
    var _result: Res<Value> {
        get { return storage._result }
        set { storage._result = newValue }
    }
    
    var _needsRecalculation: Bool {
        get { return storage._needsRecalculation }
        set { storage._needsRecalculation = newValue }
    }
    
    var context: FigureContext? {
        get { return storage.context }
        set { storage.context = newValue }
    }
    
    var selected: Bool {
        get { return storage.selected }
        set { storage.selected = newValue }
    }
    
    func setChildOf(_ array: [FigureBase]) {
        if let first = array.first {
            first.context?.append(self)
        }
        receive(from: array as [Transmitter])
    }
}
