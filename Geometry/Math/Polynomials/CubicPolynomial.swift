//
//  CubicPolynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct CubicPolynomial<V: RawValueProtocol>: Polynomial, ComplexSolvable {
    let a0: V
    let a1: V
    let a2: V
    let a3: V
    static var degree: UInt { return 3 }
    var roots: ComplexRoots<V> {
        guard !a3.isZero else {
            return popped.roots
        }
        guard !a0.isZero else {
            return ComplexRoots.some([Complex(0)]) + shifted.roots
        }
        guard a2.isZero else {
            let a32 = a3 * a3
            let a33 = a32 * a3
            let a22 = a2 * a2
            let a23 = a22 * a2
            let pnum = (3 * a3 * a1 - a22)
            let p = pnum / (3 * a32)
            let nq0 = 2 * a23
            let nq1 = 9 * a3 * a2 * a1
            let nq2 = 27 * a32 * a0
            let nq = nq0 - nq1 + nq2
            let dq = 27 * a33
            let q = nq / dq
            let diff = -a2 / (3 * a3)
            return CubicPolynomial(a0: q, a1: p, a2: 0, a3: 1).roots.map { $0 + diff }
        }
        let p = a1 / a3
        let q = a0 / a3
        let p3 = p / 3
        let q2 = q / 2
        let p27 = p3 * p3 * p3
        let q4 = q2 * q2
        let d = q4 + p27
        if d >= 0 {
            let zeta = Complex<V>(-1 / 2, (3 as V).squareRoot() / 2)
            let zeta2 = zeta.conjugate
            let sqD = d.squareRoot()
            let r1 = (-q2 + sqD).cubeRoot()
            let r2 = (-q2 - sqD).cubeRoot()
            return .some([Complex(r1 + r2), r1 * zeta + r2 * zeta2, r1 * zeta2 + r2 * zeta])
        } else {
            let sqD = (-d).squareRoot()
            let angle = sqD.arctangent2(-q2)
            let norm3 = 2 * (-d + q4).squareRoot().cubeRoot()
            let angle3 = angle / 3
            let twoPiThirds = V.twoPiThirds
            return .some([norm3 * angle3.cosine(), norm3 * (angle3 + twoPiThirds).cosine(), norm3 * (angle3 - twoPiThirds).cosine()].map{ Complex($0) })
        }
    }
    var popped: QuadraticPolynomial<V> { return QuadraticPolynomial(a0: a0, a1: a1, a2: a2) }
    var shifted: QuadraticPolynomial<V> { return QuadraticPolynomial(a0: a1, a1: a2, a2: a3) }
    var derivative: QuadraticPolynomial<V> { return QuadraticPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3) }
    func of(_ x: V) -> V {
        let x2 = x * x
        let x3 = x2 * x
        let t1 = a1 * x
        let t2 = a2 * x2
        let t3 = a3 * x3
        return a0 + t1 + t2 + t3
    }
    var description: String {
        return "\(a3) x^3 + " + popped.description
    }
}
