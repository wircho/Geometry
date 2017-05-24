//
//  Scalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

// MARK: - Scalar Base Class

protocol Scalar: Figure {
    associatedtype V: FloatingPoint
    var result: Res<V> { get }
}

/*
extension Scalar {
    func draw(in rect: CGRect) {
        // Does nothing
    }
}
 
 */

// TODO: - Segment Length, Coordinate, Angle
