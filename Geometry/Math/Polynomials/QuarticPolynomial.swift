//
//  QuarticPolynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct QuarticPolynomial<V: RawValueProtocol>: Polynomial, ComplexSolvable {
    let a0: V
    let a1: V
    let a2: V
    let a3: V
    let a4: V
    static var degree: UInt { return 4 }
    var roots: ComplexRoots<V> {
        guard !a4.isZero else {
            return popped.roots
        }
        guard !a0.isZero else {
            return ComplexRoots.some([Complex(0)]) + shifted.roots
        }
        guard !a3.isZero || !a1.isZero else {
            let qCRoots = QuadraticPolynomial(a0: a0, a1: a2, a2: a4).roots
            switch qCRoots {
            case .all: return .all
            case .some(let qRoots):
                let roots = qRoots.map(sqrts)
                return .some(roots[0] + roots[1])
            }
        }
        var a = a4
        var b = a3
        var c = a2
        var d = a1
        let e = a0
        
        let a_1 = b/a
        b = c/a
        c = d/a
        d = e/a
        a = a_1
        
        let a_2 = a*a
        let minus3a2 = -3 * a_2
        let ac64 = 64 * a * c
        let a2b16 = 16 * a_2 * b
        let aOn4 = a / 4
        
        let p = b + minus3a2 / 8
        let ab4 = 4 * a * b
        let q = (a_2 * a - ab4) / 8 + c
        let r1 = minus3a2 * a_2 - ac64 + a2b16
        let r = r1 / 256 + d
        
        guard !q.isZero else {
            let qCRoots = QuadraticPolynomial(a0: r, a1: p, a2: 1).roots
            switch qCRoots {
            case .all: return .all
            case .some(let qRoots):
                let roots = qRoots.map(sqrts)
                return .some((roots[0] + roots[1]).map { $0 - aOn4 })
            }
        }
        
        let p2 = p * p
        let q2On8 = q * q / 8
        
        let cb = 5 * p / 2
        let cc = 2 * p2 - r
        let cd = p * (p2 - r) / 2 - q2On8
        
        let yCRoots = CubicPolynomial(a0: cd, a1: cc, a2: cb, a3: 1).roots
        
        guard var yRoots = yCRoots.array else {
            return .all
        }
        
        yRoots.sort { $0.isReal && !$1.isReal }
        let y = yRoots[0]
        
        let y2 = 2 * y
        let sqrtPPlus2y = sqrt(p + y2)
        precondition(!sqrtPPlus2y.isZero, "Failed to properly handle the case of the depressed quartic being biquadratic")
        
        let p3 = 3 * p
        let q2 = 2 * q
        let fraction = q2/sqrtPPlus2y
        let p3Plus2y = p3 + y2
        
        let t1 = sqrt(-(p3Plus2y + fraction))
        let t2 = sqrt(-(p3Plus2y - fraction))
        let t3 = sqrt(-(p3Plus2y + fraction))
        let t4 = sqrt(-(p3Plus2y - fraction))
        
        let u1 = (sqrtPPlus2y + t1) / 2
        let u2 = (-sqrtPPlus2y + t2) / 2
        let u3 = (sqrtPPlus2y - t3) / 2
        let u4 = (-sqrtPPlus2y - t4) / 2
        
        return .some([u1 - aOn4, u2 - aOn4, u3 - aOn4, u4 - aOn4])
    }
    var popped: CubicPolynomial<V> { return CubicPolynomial(a0: a0, a1: a1, a2: a2, a3: a3) }
    var shifted: CubicPolynomial<V> { return CubicPolynomial(a0: a1, a1: a2, a2: a3, a3: a4) }
    var derivative: CubicPolynomial<V> { return CubicPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3, a3: 4 * a4) }
    func of(_ x: V) -> V {
        let x2 = x * x
        let x3 = x2 * x
        let x4 = x3 * x
        let t1 = a1 * x
        let t2 = a2 * x2
        let t3 = a3 * x3
        let t4 = a4 * x4
        return a0 + t1 + t2 + t3 + t4
    }
    var description: String {
        return "\(a4) x^4 + " + popped.description
    }
}
