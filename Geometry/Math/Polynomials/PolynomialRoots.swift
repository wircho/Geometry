//
//  PolynomialRoots.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

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

typealias ComplexRoots<V: RawValueProtocol> = Roots<Complex<V>>
typealias RealRoots<V: RawValueProtocol> = Roots<V>

protocol Divisible: Polynomial {
    func dividedBy(_ root: V) -> Lower
}

protocol RealSolvable: Polynomial {
    var realRoots: RealRoots<V> { get }
}

protocol ComplexSolvable: RealSolvable {
    var roots: ComplexRoots<V> { get }
}

extension ComplexSolvable {
    var realRoots: RealRoots<V> {
        return roots.flatMap { $0.isReal ? $0.re : nil }
    }
}
