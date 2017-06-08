//
//  QuinticPolynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-22.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct QuinticPolynomial<V: RawValueProtocol>: Polynomial, RealSolvable, Divisible {
    let a0: V
    let a1: V
    let a2: V
    let a3: V
    let a4: V
    let a5: V
    static var degree: UInt { return 5 }
    var realRoots: RealRoots<V> {
        guard !a5.isZero else {
            return popped.roots.flatMap { $0.isReal ? $0.re : nil }
        }
        guard !a0.isZero else {
            return RealRoots.some([0]) + shifted.roots.flatMap { $0.isReal ? $0.re : nil }
        }
        guard var critical = derivative.realRoots.array?.sorted(by: <) else {
            return .all
        }
        for c in critical {
            guard !of(c).isZero else {
                return dividedBy(c).realRoots
            }
        }
        var lower: V = min(-1, (critical.min() ?? 0) - 1)
        var upper: V = max(1, (critical.max() ?? 0) + 1)
        if a5 < 0 {
            while of(lower) <= 0 {
                lower *= 2
            }
            while of(upper) >= 0 {
                upper *= 2
            }
        } else {
            while of(lower) >= 0 {
                lower *= 2
            }
            while of(upper) <= 0 {
                upper *= 2
            }
        }
        critical.append(upper)
        var lower0 = lower
        var sign = of(lower0).sign
        var array: [V] = []
        for upper0 in critical {
            let upperSign = of(upper0).sign
            if upperSign != sign {
                array.append(sign == .minus ? findRoot(lower0, upper0) : findRoot(upper0, lower0))
                lower0 = upper0
                sign = upperSign
            }
        }
        return .some(array)
    }
    var popped: QuarticPolynomial<V> { return QuarticPolynomial(a0: a0, a1: a1, a2: a2, a3: a3, a4: a4) }
    var shifted: QuarticPolynomial<V> { return QuarticPolynomial(a0: a1, a1: a2, a2: a3, a3: a4, a4: a5) }
    var derivative: QuarticPolynomial<V> { return QuarticPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3, a3: 4 * a4, a4: 5 * a5) }
    func of(_ x: V) -> V {
        let x2 = x * x
        let x3 = x2 * x
        let x4 = x3 * x
        let x5 = x4 * x
        let t1 = a1 * x
        let t2 = a2 * x2
        let t3 = a3 * x3
        let t4 = a4 * x4
        let t5 = a5 * x5
        return a0 + t1 + t2 + t3 + t4 + t5
    }
    func dividedBy(_ root: V) -> QuarticPolynomial<V> {
        let shifted4 = shifted
        let shifted3 = shifted4.shifted
        let shifted2 = shifted3.shifted
        let shifted1 = shifted2.shifted
        let shifted0 = shifted1.shifted
        return QuarticPolynomial(
            a0: shifted4.of(root),
            a1: shifted3.of(root),
            a2: shifted2.of(root),
            a3: shifted1.of(root),
            a4: shifted0
        )
    }
    private func findRoot(_ lower: V, _ upper: V) -> V {
        let middle = (lower + upper) / 2
        guard abs(upper - lower) > 2 / 100000 else {
            return middle
        }
        let ofMiddle = of(middle)
        if ofMiddle > 0 {
            return findRoot(lower, middle)
        } else if ofMiddle < 0 {
            return findRoot(middle, upper)
        } else {
            return middle
        }
    }
    var description: String {
        return "\(a5) x^5 + " + popped.description
    }
}
