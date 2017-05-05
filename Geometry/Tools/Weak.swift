//
//  Weak.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol WeakProtocol {
    associatedtype T: AnyObject
    var object: T? { get }
    init(_ object: T)
}

struct Weak<T: AnyObject>: WeakProtocol, Hashable {
    private weak var _object: T?
    
    var object: T? { return _object }
    
    private(set) var hashValue: Int
    
    init(_ object: T) {
        _object = object
        var obj = object
        hashValue = withUnsafePointer(to: &obj) { $0.hashValue }
    }
}

extension Weak {
    static func tuple(_ t0: T, _ t1: T) -> (Weak<T>, Weak<T>) {
        return (Weak(t0), Weak(t1))
    }
    
    static func tuple(_ t0: T, _ t1: T, _ t2: T) -> (Weak<T>, Weak<T>, Weak<T>) {
        return (Weak(t0), Weak(t1), Weak(t2))
    }
}

func ==<T: AnyObject, S: AnyObject>(lhs: Weak<T>, rhs: Weak<S>) -> Bool {
    return lhs.object === rhs.object
}

typealias WeakObject = Weak<AnyObject>
