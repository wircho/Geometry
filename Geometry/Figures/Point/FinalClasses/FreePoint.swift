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
            signal = true
        }
    }
    
    init (at position: Spot) {
        self.position = position
        super.init()
    }
    
    override func recalculate() -> SpotResult {
        return .success(position)
    }
}
