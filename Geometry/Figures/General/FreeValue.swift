//
//  FreeValue.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol FreeValuedBase: class {
    func placeNear(point: RawPoint)
}

protocol FreeValued: FreeValuedBase {
    associatedtype FreeValue
    var _position: FreeValue { get set }
    func nearestPosition(from point: RawPoint) -> Result<FreeValue, MathError>
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
    func placeNear(point: RawPoint) {
        guard let position = nearestPosition(from: point).value else {
            return
        }
        self.position = position
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
