//
//  FreeValued.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

protocol FreeValuedBase: class {
    func placeNear(cgPoint: CGPoint)
}

protocol FreeValued: FreeValuedBase {
    associatedtype FreeValue
    associatedtype P: RawPointProtocol
    var _freeValue: FreeValue { get set }
    func nearestFreeValue(from point: P) -> Res<FreeValue>
}

extension FreeValued where Self: Recalculator, Self: Transmitter {
    var freeValue: FreeValue {
        get {
            return _freeValue
        }
        set {
            _freeValue = newValue
            needsRecalculation = true
        }
    }
    func placeNear(point: P) {
        guard let freeValue = nearestFreeValue(from: point).value else {
            return
        }
        self.freeValue = freeValue
    }
    func placeNear(cgPoint: CGPoint) {
        placeNear(point: cgPoint as! P)
    }
}

extension FreeValued where Self: Recalculator, Self: Transmitter, Self.ResultValue: ResultProtocol, Self.ResultValue.Value == FreeValue {
    func recalculate() -> ResultValue {
        return ResultValue(value: freeValue)
    }
}

extension FreeValued where Self: Figure {
    func compare(with other: Self) -> Bool { return self === other }
}
