//
//  FreeScalar.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

class FreeScalar: Scalar {
    var position: CGFloat {
        didSet {
            signal = true
        }
    }
    
    init (at position: CGFloat) {
        self.position = position
        super.init()
    }
    
    override func recalculate() -> RCGFloat {
        return .success(position)
    }
}
