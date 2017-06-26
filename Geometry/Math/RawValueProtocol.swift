//
//  RawValueProtocol.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Darwin

protocol RawValueProtocol: FloatingPoint {
    func sine() -> Self
    func cosine() -> Self
    func arctangent2(_ x: Self) -> Self
    func cubeRoot() -> Self
}

extension RawValueProtocol {
    static var twoPi: Self {
        return 2 * pi
    }
    
    static var twoPiThirds: Self {
        return twoPi / 3
    }
}

extension Double: RawValueProtocol {
    func sine() -> Double { return sin(self) }
    func cosine() -> Double { return cos(self) }
    func arctangent2(_ x: Double) -> Double { return atan2(self, x) }
    func cubeRoot() -> Double {
        if self >= 0 {
            return pow(self, 1/3)
        } else {
            return -pow(-self, 1/3)
        }
    }
}

extension Float: RawValueProtocol {
    func sine() -> Float { return sin(self) }
    func cosine() -> Float { return cos(self) }
    func arctangent2(_ x: Float) -> Float { return atan2(self, x) }
    func cubeRoot() -> Float {
        if self >= 0 {
            return pow(self, 1/3)
        } else {
            return -pow(-self, 1/3)
        }
    }
}
