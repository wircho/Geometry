//
//  LinearPolynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

extension RawValueProtocol {
    var roots: ComplexRoots<Self> { return isZero ? .all : .some([]) }
}

struct LinearPolynomial<V: RawValueProtocol>: Polynomial, ComplexSolvable {
    let a0: V
    let a1: V
    static var degree: UInt { return 1 }
    var roots: ComplexRoots<V> {
        let value = (-a0) / a1
        guard !value.isInfinite else {
            return popped.roots
        }
        return .some([value.complex])
    }
    var popped: V { return a0 }
    var shifted: V { return a1 }
    var derivative: V { return a1 }
    func of(_ x: V) -> V {
        return a0 + a1 * x
    }
    var description: String {
        return "\(a1) x + \(a0)"
    }
}
