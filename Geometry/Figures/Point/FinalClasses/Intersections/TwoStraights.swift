//
//  TwoStraights.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

import CoreGraphics
import Result

class TwoStraightIntersection: Point {
    var straights: (Weak<Straight>, Weak<Straight>)
    
    init(_ s0: Straight, _ s1: Straight) {
        self.straights = Weak.tuple(s0, s1)
        super.init(unsorted: [s0, s1])
    }
    
    override func getRaw() -> RCGPoint {
        return intersection(straights.0.defaultedRaw, straights.1.defaultedRaw)
    }
}
