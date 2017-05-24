//
//  Polynomial.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol Polynomial: CustomStringConvertible {
    associatedtype V: RawValueProtocol
    associatedtype Lower
    static var degree: UInt { get }
    var popped: Lower { get }
    var shifted: Lower { get }
    var derivative: Lower { get }
    func of(_ x: V) -> V
}

extension Polynomial {
    var degree: UInt {
        return Self.degree
    }
}
