//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreePoint: Point {
    var position: Spot {
        didSet {
            needsRecalculation = true
        }
    }
    
    init (at position: Spot) {
        self.position = position
        super.init()
    }
    
    convenience init (x: Float, y: Float) {
        self.init(at: Spot(x: x, y: y))
    }
    
    override func recalculate() -> SpotResult {
        return .success(position)
    }
}
