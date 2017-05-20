//
//  Bounded.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-19.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Bounded {
    var startingPoint: Point? { get }
    var endingPoint: Point? { get }
}
