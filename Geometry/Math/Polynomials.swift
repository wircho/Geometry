//
//  Polynomials.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

struct Complex: CustomStringConvertible {
    let re: Float
    let im: Float?
    
    init(_ re: Float, _ im: Float? = nil) {
        self.re = re
        guard let im = im else {
            self.im = nil
            return
        }
        self.im = im.isZero ? nil : im
    }
    
    init(norm: Float, angle: Float) {
        re = norm * cos(angle)
        im = norm * sin(angle)
    }
    
    var isReal: Bool {
        guard let im = im else { return true }
        return im.isZero
    }
    
    static func +(lhs: Complex, rhs: Float) -> Complex {
        return Complex(lhs.re + rhs, lhs.im)
    }
    
    static func +(lhs: Float, rhs: Complex) -> Complex {
        return rhs + lhs
    }
    
    static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(lhs.re + rhs.re, lhs.im.flatMap { l in rhs.im.map { r in l + r } })
    }
    
    static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(lhs.re - rhs.re, lhs.im.flatMap { l in rhs.im.map { r in l - r } })
    }
    
    static func -(lhs: Complex, rhs: Float) -> Complex {
        return Complex(lhs.re - rhs, lhs.im)
    }
    
    static prefix func -(v: Complex) -> Complex {
        return Complex(-v.re, v.im.map { -$0 })
    }
    
    static func *(lhs: Float, rhs: Complex) -> Complex {
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
    
    static func /(lhs: Complex, rhs: Float) -> Complex {
        return Complex(lhs.re / rhs, lhs.im.map { $0 / rhs })
    }
    
    static func /(lhs: Float, rhs: Complex) -> Complex {
        return Complex(lhs) / rhs
    }
    
    static func /(lhs: Complex, rhs: Complex) -> Complex {
        return (lhs * rhs.conjugate) / rhs.squareNorm.re
    }
    
    var isZero: Bool {
        return re.isZero && im.map({ $0.isZero }) ?? true
    }
    
    var description: String {
        guard let im = im else { return re.description }
        return re.description + " + " + im.description + " i"
    }
}

func sqrt(_ v: Complex) -> Complex {
    guard let im = v.im else {
        if v.re >= 0 {
            return Complex(sqrt(v.re))
        } else {
            return Complex(0, sqrt(-v.re))
        }
    }
    return Complex(norm: sqrt(v.norm.re), angle: atan2(im, v.re) / 2)
}

func sqrts(_ v: Complex) -> [Complex] {
    let sq = sqrt(v)
    return [sq, -sq]
}

enum Roots<T> {
    case all
    case some([T])
    
    func map<S>(_ f: (T) -> S) -> Roots<S> {
        switch self {
        case .all: return .all
        case .some(let array): return .some(array.map(f))
        }
    }

    func flatMap<S>(_ f: (T) -> S?) -> Roots<S> {
        switch self {
        case .all: return .all
        case .some(let array): return .some(array.flatMap(f))
        }
    }
    
    static func +(lhs: Roots, rhs: Roots) -> Roots {
        guard case .some(let l) = lhs, case .some(let r) = rhs else {
            return .all
        }
        return .some(l + r)
    }
    
    var array: [T]? {
        switch self {
        case .all: return nil
        case .some(let a): return a
        }
    }
}

typealias ComplexRoots = Roots<Complex>
typealias RealRoots = Roots<Float>

extension Float {
    var complex: Complex {
        return Complex(self)
    }
}

protocol Polynomial {
    associatedtype Lower
    static var degree: UInt { get }
    var popped: Lower { get }
    var shifted: Lower { get }
    var derivative: Lower { get }
    func of(_ x: Float) -> Float
}

protocol Divisible: Polynomial {
    func dividedBy(_ root: Float) -> Lower
}

protocol RealSolvable {
    var realRoots: RealRoots { get }
}

protocol ComplexSolvable: RealSolvable {
    var roots: ComplexRoots { get }
}

extension ComplexSolvable {
    var realRoots: RealRoots {
        return roots.flatMap { $0.isReal ? $0.re : nil }
    }
}

extension Polynomial {
    var degree: UInt {
        return Self.degree
    }
}

extension Float: Polynomial, ComplexSolvable {
    static var degree: UInt { return 0 }
    var roots: ComplexRoots { return isZero ? .all : .some([]) }
    var popped: Float { return 0 }
    var shifted: Float { return 0 }
    var derivative: Float { return 0 }
    func of(_ x: Float) -> Float { return self }
}

struct LinearPolynomial: Polynomial, ComplexSolvable {
    let a0: Float
    let a1: Float
    static let degree: UInt = 1
    var roots: ComplexRoots {
        let value = (-a0) / a1
        guard !value.isInfinite else {
            return popped.roots
        }
        return .some([value.complex])
    }
    var popped: Float { return a0 }
    var shifted: Float { return a1 }
    var derivative: Float { return a1 }
    func of(_ x: Float) -> Float {
        return a0 + a1 * x
    }
}

struct QuadraticPolynomial: Polynomial, ComplexSolvable {
    let a0: Float
    let a1: Float
    let a2: Float
    static let degree: UInt = 2
    var roots: ComplexRoots {
        guard !a2.isZero else {
            return popped.roots
        }
        guard !a0.isZero else {
            return ComplexRoots.some([Complex(0)]) + shifted.roots
        }
        let dSq = a1 * a1 - 4 * a0 * a2
        let twoA2 = 2 * a2
        if dSq >= 0 {
            let d = sqrt(dSq)
            return .some([Complex((-a1 + d) / twoA2), Complex((-a1 - d) / twoA2)])
        } else {
            let d = sqrt(-dSq)
            let md = -d
            let r0 = Complex(-a1, d) / twoA2
            let r1 = Complex(-a1, md) / twoA2
            return .some([r0, r1])
        }
    }
    var popped: LinearPolynomial { return LinearPolynomial(a0: a0, a1: a1) }
    var shifted: LinearPolynomial { return LinearPolynomial(a0: a1, a1: a2) }
    var derivative: LinearPolynomial { return LinearPolynomial(a0: a1, a1: 2 * a2) }
    func of(_ x: Float) -> Float {
        return a0 + a1 * x + a2 * x * x
    }
}

private let oneThird: Float = 1 / 3
private func cur(_ v: Float) -> Float {
    if v >= 0 {
        return pow(v, oneThird)
    } else {
        return -pow(-v, oneThird)
    }
}

private let zeta = Complex(-0.5, sqrt(Float(3.0)) * 0.5)
private let zeta2 = zeta.conjugate
private let twoPi3 = Float(2 * M_PI / 3)
struct CubicPolynomial: Polynomial, ComplexSolvable {
    let a0: Float
    let a1: Float
    let a2: Float
    let a3: Float
    static let degree: UInt = 3
    var roots: ComplexRoots {
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
            let p = (3 * a3 * a1 - a22) / (3 * a32)
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
            let sqD = sqrt(d)
            let r1 = cur(-q2 + sqD)
            let r2 = cur(-q2 - sqD)
            return .some([Complex(r1 + r2), r1 * zeta + r2 * zeta2, r1 * zeta2 + r2 * zeta])
        } else {
            let sqD = sqrt(-d)
            let angle = atan2(sqD, -q2)
            let norm3 = 2 * cur(sqrt(-d + q4))
            let angle3 = angle / 3
            return .some([norm3 * cos(angle3), norm3 * cos(angle3 + twoPi3), norm3 * cos(angle3 - twoPi3)].map{ Complex($0) })
        }
    }
    var popped: QuadraticPolynomial { return QuadraticPolynomial(a0: a0, a1: a1, a2: a2) }
    var shifted: QuadraticPolynomial { return QuadraticPolynomial(a0: a1, a1: a2, a2: a3) }
    var derivative: QuadraticPolynomial { return QuadraticPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3) }
    func of(_ x: Float) -> Float {
        let x2 = x * x
        return a0 + a1 * x + a2 * x2 + a3 * x2 * x
    }
}

struct QuarticPolynomial: Polynomial, ComplexSolvable {
    let a0: Float
    let a1: Float
    let a2: Float
    let a3: Float
    let a4: Float
    static let degree: UInt = 4
    var roots: ComplexRoots {
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
        let minus3a2 = -3.0*a_2
        let ac64 = 64.0*a*c
        let a2b16 = 16.0*a_2*b
        let aOn4 = a/4.0
        
        let p = b + minus3a2/8.0
        let ab4 = 4.0*a*b
        let q = (a_2*a - ab4)/8.0 + c
        let r1 = minus3a2*a_2 - ac64 + a2b16
        let r = r1/256.0 + d
        
        guard !q.isZero else {
            let qCRoots = QuadraticPolynomial(a0: r, a1: p, a2: 1).roots
            switch qCRoots {
            case .all: return .all
            case .some(let qRoots):
                let roots = qRoots.map(sqrts)
                return .some((roots[0] + roots[1]).map { $0 - aOn4 })
            }
        }
        
        let p2 = p*p
        let q2On8 = q*q/8.0
        
        let cb = 2.5*p
        let cc = 2.0*p2 - r
        let cd = 0.5*p*(p2-r) - q2On8
        
        let yCRoots = CubicPolynomial(a0: cd, a1: cc, a2: cb, a3: 1).roots
        
        guard var yRoots = yCRoots.array else {
            return .all
        }
        
        yRoots.sort { $0.isReal && !$1.isReal }
        let y = yRoots[0]
        
        let y2 = 2.0 * y
        let sqrtPPlus2y = sqrt(p + y2)
        precondition(!sqrtPPlus2y.isZero, "Failed to properly handle the case of the depressed quartic being biquadratic")
        
        let p3 = 3.0*p
        let q2 = 2.0*q
        let fraction = q2/sqrtPPlus2y
        let p3Plus2y = p3 + y2
        
        let u1 = 0.5*(sqrtPPlus2y + sqrt(-(p3Plus2y + fraction)))
        let u2 = 0.5*(-sqrtPPlus2y + sqrt(-(p3Plus2y - fraction)))
        let u3 = 0.5*(sqrtPPlus2y - sqrt(-(p3Plus2y + fraction)))
        let u4 = 0.5*(-sqrtPPlus2y - sqrt(-(p3Plus2y - fraction)))
        
        return .some([u1 - aOn4, u2 - aOn4, u3 - aOn4, u4 - aOn4])
    }
    var popped: CubicPolynomial { return CubicPolynomial(a0: a0, a1: a1, a2: a2, a3: a3) }
    var shifted: CubicPolynomial { return CubicPolynomial(a0: a1, a1: a2, a2: a3, a3: a4) }
    var derivative: CubicPolynomial { return CubicPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3, a3: 4 * a4) }
    func of(_ x: Float) -> Float {
        let x2 = x * x
        let x3 = x2 * x
        return a0 + a1 * x + a2 * x2 + a3 * x3 + a4 * x3 * x
    }
}

private let quinticError: Float = 0.01
private let twiceQuinticError = 2 * quinticError
struct QuinticPolynomial: Polynomial, RealSolvable, Divisible {
    let a0: Float
    let a1: Float
    let a2: Float
    let a3: Float
    let a4: Float
    let a5: Float
    static let degree: UInt = 5
    var realRoots: RealRoots {
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
        var lower: Float = -1
        var upper: Float = 1
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
        var array: [Float] = []
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
    var popped: QuarticPolynomial { return QuarticPolynomial(a0: a0, a1: a1, a2: a2, a3: a3, a4: a4) }
    var shifted: QuarticPolynomial { return QuarticPolynomial(a0: a1, a1: a2, a2: a3, a3: a4, a4: a5) }
    var derivative: QuarticPolynomial { return QuarticPolynomial(a0: a1, a1: 2 * a2, a2: 3 * a3, a3: 4 * a4, a4: 5 * a5) }
    func of(_ x: Float) -> Float {
        let x2 = x * x
        let x3 = x2 * x
        let x4 = x3 * x
        return a0 + a1 * x + a2 * x2 + a3 * x3 + a4 * x4 + a5 * x4 * x
    }
    func dividedBy(_ root: Float) -> QuarticPolynomial {
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
            a4: shifted0.of(root)
        )
    }
    private func findRoot(_ lower: Float, _ upper: Float) -> Float {
        let middle = (lower + upper) / 2
        guard abs(upper - lower) > twiceQuinticError else {
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
}

