//
//  Recalculator.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: - Recalculates On Demand

protocol RecalculatorBase: class {
    var _needsRecalculation: Bool { get set }
}

// MARK: - RecalculatorBase + Transmitter

extension RecalculatorBase where Self: Transmitter {
    
// MARK: - Needs Recalculation
    
    var needsRecalculation: Bool {
        get {
            return _needsRecalculation
        }
        set {
            guard newValue != _needsRecalculation else {
                return
            }
            if newValue {
                send { transmitter in
                    if let r = transmitter as? RecalculatorBase {
                        r._needsRecalculation = true
                    }
                }
            } else {
                _needsRecalculation = false
            }
        }
    }
}

// MARK: - Main Protocol

protocol Recalculator: RecalculatorBase {
    associatedtype ResultValue
    var _result: ResultValue { get set }
    func recalculate() -> ResultValue
}

// MARK: - Recalculator + Transmitter

extension Recalculator where Self: Transmitter {
    var result: ResultValue {
        guard needsRecalculation else {
            return _result
        }
        _result = recalculate()
        needsRecalculation = false
        return _result
    }
}
