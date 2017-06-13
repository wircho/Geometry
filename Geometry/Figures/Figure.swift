//
//  Figure.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Figure

protocol FigureBase: LazyNodeBase {
    var context: FigureContext? { get set }
    //var selected: Bool { get set }
}

struct FigureStorage<Value> {
    weak var context: FigureContext?
    var receivers: [() -> LazyNodeBase?] = []
    var _result: Res<Value> = .none /* {
        didSet {
            if case .success = oldValue, case .failure = _result, selected {
                selected = false
            }
        }
    } */
    var _needsUpdate = true {
        didSet {
            if _needsUpdate && !oldValue {
                context?.setFiguresWillRecalculate()
            }
        }
    }
    /*var selected = false {
        didSet {
            if selected != oldValue {
                context?.setFiguresWillRecalculate()
            }
        }
    }*/
//    init(_ initial: ResultValue) {
//        self._result = initial
//    }
}

protocol Figure: FigureBase, LazyNode {
    associatedtype FigureValue
    var storage: FigureStorage<FigureValue> { get set }
    func compare(with other: Self) -> Bool
}

extension Figure {
    var receivers: [() -> LazyNodeBase?] {
        get { return storage.receivers }
        set { storage.receivers = newValue }
    }
    
    var _result: Res<FigureValue> {
        get { return storage._result }
        set { storage._result = newValue }
    }
    
    var _needsUpdate: Bool {
        get { return storage._needsUpdate }
        set { storage._needsUpdate = newValue }
    }
    
    var context: FigureContext? {
        get { return storage.context }
        set { storage.context = newValue }
    }
    
   /* var selected: Bool {
        get { return storage.selected }
        set { storage.selected = newValue }
    }
    */
    
    func setChildOf(_ array: [FigureBase]) {
        if let first = array.first {
            first.context?.append(self)
        }
        receive(from: array as [LazyNodeBase])
    }
}
