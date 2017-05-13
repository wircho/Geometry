//
//  OneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol OneDimensional: class {
//    var touchingDefiningPoints: [Point] { get }
//    var constrainedPoints: [Point] { get }
//    func intersectionPointsNotWith(other: Transmitter?) -> [Point]
    func at(_ pos: Float) -> Spot?
}
