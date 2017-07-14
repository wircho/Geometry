//
//  Complex.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

struct Complex<V: RawValueProtocol>: CustomStringConvertible {
    let re: V
    let im: V?
    
    init(_ re: V, _ im: V? = nil) {
        self.re = re
        guard let im = im else {
            self.im = nil
            return
        }
        self.im = im.isZero ? nil : im
    }
    
    init(norm: V, angle: V) {
        re = norm * angle.cosine()
        im = norm * angle.sine()
    }
    
    var isReal: Bool {
        guard let im = im else { return true }
        return im.isZero
    }
    
    static func +(lhs: Complex, rhs: V) -> Complex {
        return Complex(lhs.re + rhs, lhs.im)
    }
    
    static func +(lhs: V, rhs: Complex) -> Complex {
        return rhs + lhs
    }
    
    static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(lhs.re + rhs.re, lhs.im.flatMap { l in rhs.im.map { r in l + r } })
    }
    
    static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(lhs.re - rhs.re, lhs.im.flatMap { l in rhs.im.map { r in l - r } })
    }
    
    static func -(lhs: Complex, rhs: V) -> Complex {
        return Complex(lhs.re - rhs, lhs.im)
    }
    
    static prefix func -(v: Complex) -> Complex {
        return Complex(-v.re, v.im.map { -$0 })
    }
    
    static func *(lhs: V, rhs: Complex) -> Complex {
        return Complex(lhs * rhs.re, rhs.im.map { lhs * $0 })
    }
    
    static func *(lhs: Complex, rhs: Complex) -> Complex {
        guard let lhsIm = lhs.im else {
            return lhs.re * rhs
        }
        guard let rhsIm = rhs.im else {
            return rhs.re * lhs
        }
        return Complex(lhs.re * rhs.re - lhsIm * rhsIm, lhs.re * rhsIm + lhsIm * rhs.re)
    }
    
    var conjugate: Complex {
        return Complex(re, im.map { -$0 })
    }
    
    var squareNorm: Complex {
        return Complex(re * re + (im.map { $0 * $0 } ?? 0))
    }
    
    var norm: Complex {
        return Complex(sqrt(squareNorm.re))
    }
    
    static func /(lhs: Complex, rhs: V) -> Complex {
        return Complex(lhs.re / rhs, lhs.im.map { $0 / rhs })
    }
    
    static func /(lhs: V, rhs: Complex) -> Complex {
        return Complex(lhs) / rhs
    }
    
    static func /(lhs: Complex, rhs: Complex) -> Complex {
        return (lhs * rhs.conjugate) / rhs.squareNorm.re
    }
    
    var isZero: Bool {
        return re.isZero && im.map({ $0.isZero }) ?? true
    }
    
    var description: String {
        guard let im = im else { return "\(re)" }
        return "\(re) + \(im) i"
    }
}

func sqrt<V>(_ v: Complex<V>) -> Complex<V> {
    guard let im = v.im else {
        if v.re >= 0 {
            return Complex(sqrt(v.re))
        } else {
            return Complex(0, sqrt(-v.re))
        }
    }
    return Complex(norm: sqrt(v.norm.re), angle: im.arctangent2(v.re) / 2)
}

func sqrts<V>(_ v: Complex<V>) -> [Complex<V>] {
    let sq = sqrt(v)
    return [sq, -sq]
}

extension RawValueProtocol {
    var complex: Complex<Self> {
        return Complex(self)
    }
}
