//
//  FreeScalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreeScalar: Scalar {
    var position = RCGFloat.inexistent {
        didSet {
            signal = true
        }
    }
    
    init (at position: RCGFloat) {
        super.init()
        self.position = position
    }
    
    override func recalculate() -> RCGFloat {
        return position
    }
}
