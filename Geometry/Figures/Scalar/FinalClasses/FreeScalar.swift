//
//  FreeScalar.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreeScalar: Scalar {
    var value = RCGFloat.inexistent {
        didSet {
            gotSignal = true
        }
    }
    
    init (at value: RCGFloat) {
        super.init()
        self.value = value
    }
    
    override func getRaw() -> RCGFloat {
        return value
    }
}
