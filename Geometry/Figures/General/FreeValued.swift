//
//  FreeValued.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol FreeValued: class {
    associatedtype FreeValue
    associatedtype FreeValuePoint: RawPointProtocol
    var _freeValue: FreeValue { get set }
    func nearestFreeValue(from point: FreeValuePoint) -> FreeValue?
}

extension FreeValued where Self: LazyNode {
    var freeValue: FreeValue {
        get { return _freeValue }
        set {
            _freeValue = newValue
            needsUpdate = true
        }
    }
    func placeNear(point: FreeValuePoint) {
        guard let freeValue = nearestFreeValue(from: point) else { return }
        self.freeValue = freeValue
    }
}

extension FreeValued where Self: Figure {
    func compare(with other: Self) -> Bool { return self === other }
}

extension FreeValued where Self: LazyNode, Self.ResultValue == FreeValue? {
    func update() -> ResultValue { return freeValue }
}
