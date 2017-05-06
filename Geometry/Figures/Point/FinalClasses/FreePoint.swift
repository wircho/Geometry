//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreePoint: Point {
    var position = RCGPoint.none {
        didSet {
            signal = true
        }
    }
    
    init (at position: RCGPoint) {
        super.init()
        self.position = position
    }
    
    override func recalculate() -> RCGPoint {
        return position
    }
}
