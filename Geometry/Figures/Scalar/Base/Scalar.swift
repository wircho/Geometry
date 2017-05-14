//
//  Scalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Scalar Base Class

protocol Scalar: FigureBase {
    var result: FloatResult { get }
}

extension Scalar {
    func drawIn(_ rect: CGRect) {
        // Does nothing
    }
}

// TODO: - Segment Length, Coordinate, Angle
