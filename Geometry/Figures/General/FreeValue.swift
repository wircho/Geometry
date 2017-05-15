//
//  FreeValue.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol FreeValued: class {
    associatedtype FreeValue
    var _position: FreeValue { get set }
}

extension FreeValued where Self: Recalculator, Self: Transmitter {
    var position: FreeValue {
        get {
            return _position
        }
        set {
            _position = newValue
            needsRecalculation = true
        }
    }
}

extension FreeValued where Self: Recalculator, Self: Transmitter, Self.ResultValue: ResultProtocol, Self.ResultValue.Value == FreeValue {
    func recalculate() -> ResultValue {
        return ResultValue(value: position)
    }
}

extension FreeValued where Self: Figure {
    func compare(with other: Self) -> Bool { return self === other }
}
