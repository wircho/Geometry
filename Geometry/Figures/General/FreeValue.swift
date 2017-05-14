//
//  FreeValue.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol FreeValue: class {
    associatedtype Value
    var _position: Value { get set }
}

extension FreeValue where Self: Recalculator, Self: Transmitter, Self.ResultValue: ResultProtocol, Self.ResultValue.Value == Value {
    var position: Value {
        get {
            return _position
        }
        set {
            _position = newValue
            needsRecalculation = true
        }
    }
    
    func recalculate() -> ResultValue {
        return ResultValue(value: position)
    }
}
