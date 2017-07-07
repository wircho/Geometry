//
//  Touchable.swift
//  GeometrySample
//
//  Created by Adolfo Rodriguez on 2017-06-29.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol Touchable {
    associatedtype TouchPointType: RawPointProtocol
    var touchPriority: TouchPointType.Value { get }
    func gap(from point: TouchPointType) -> Res<TouchPointType.Value>
}

struct AnyTouchable<P: RawPointProtocol> {
    private let _getTouchPriority: () -> P.Value
    private let _gapFromPoint: (P) -> Res<P.Value>
    
    init(getTouchPriority: @escaping () -> P.Value, gapFromPoint: @escaping (P) -> Res<P.Value>) {
        _getTouchPriority = getTouchPriority
        _gapFromPoint = gapFromPoint
    }
    
    init<T: Touchable>(_ touchable: T) where T.TouchPointType == P {
        self.init(
            getTouchPriority: { return touchable.touchPriority },
            gapFromPoint: { return touchable.gap(from: $0) }
        )
    }
    
    var touchPriority: P.Value { return _getTouchPriority() }
    
    func gap(from point: P) -> Res<P.Value> {
        return _gapFromPoint(point)
    }
}
