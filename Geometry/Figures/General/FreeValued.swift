//
//  FreeValued.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

protocol FreeValued: class {
    associatedtype FreeValue
    associatedtype P: RawPointProtocol
    var _freeValue: FreeValue { get set }
    func nearestFreeValue(from point: P) -> Res<FreeValue>
}

extension FreeValued where Self: LazyNode {
    var freeValue: FreeValue {
        get {
            return _freeValue
        }
        set {
            _freeValue = newValue
            needsUpdate = true
        }
    }
    func placeNear(point: P) {
        guard let freeValue = nearestFreeValue(from: point).value else {
            return
        }
        self.freeValue = freeValue
    }
}

extension FreeValued where Self: LazyNode, Self.ResultValue: ResultProtocol, Self.ResultValue.Value == FreeValue {
    func update() -> ResultValue {
        return ResultValue(value: freeValue)
    }
}

extension FreeValued where Self: Figure {
    func compare(with other: Self) -> Bool { return self === other }
}
