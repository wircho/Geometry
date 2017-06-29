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
    func gap(from point: TouchPointType) -> TouchPointType.Value
}
