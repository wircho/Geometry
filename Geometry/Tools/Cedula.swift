//
//  Cedula.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// Class that assigns an unique auto-increment unsigned integer to each instance
// This is a workaround to there not being a canonical way to determine
// the order between certain objects.

struct Cedula {
    private(set) static var nextValue: UInt = 0
    var value = Cedula.nextValue
    init() { Cedula.nextValue += 1 }
}
