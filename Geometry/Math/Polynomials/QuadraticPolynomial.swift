//
//  QuadraticPolynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct QuadraticPolynomial<V: RawValueProtocol>: Polynomial, ComplexSolvable {
    let a0: V
    let a1: V
    let a2: V
    static var degree: UInt { return 2 }
    var roots: ComplexRoots<V> {
        guard !a2.isZero else {
            return popped.roots
        }
        guard !a0.isZero else {
            return ComplexRoots.some([Complex(0)]) + shifted.roots
        }
        let dSq = a1 * a1 - 4 * a0 * a2
        let twoA2 = 2 * a2
        if dSq >= 0 {
            let d = dSq.squareRoot()
            let r0 = Complex((-a1 + d) / twoA2)
            let r1 = Complex((-a1 - d) / twoA2)
            return .some([r0, r1])
        } else {
            let d = (-dSq).squareRoot()
            let md = -d
            let r0 = Complex(-a1, d) / twoA2
            let r1 = Complex(-a1, md) / twoA2
            return .some([r0, r1])
        }
    }
    var popped: LinearPolynomial<V> { return LinearPolynomial(a0: a0, a1: a1) }
    var shifted: LinearPolynomial<V> { return LinearPolynomial(a0: a1, a1: a2) }
    var derivative: LinearPolynomial<V> { return LinearPolynomial(a0: a1, a1: 2 * a2) }
    func of(_ x: V) -> V {
        return a0 + a1 * x + a2 * x * x
    }
    var description: String {
        return "\(a2) x^2 + " + popped.description
    }
}
