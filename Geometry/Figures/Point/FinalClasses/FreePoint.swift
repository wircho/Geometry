//
//  FreePoint.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreePoint: Point {
    var position: CGPoint {
        didSet {
            signal = true
        }
    }
    
    init (at position: CGPoint) {
        self.position = position
        super.init()
    }
    
    override func recalculate() -> RCGPoint {
        return .success(position)
    }
}
