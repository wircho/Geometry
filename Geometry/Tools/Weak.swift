//
//  Weak.swift
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
        hashValue = ObjectIdentifier(object).hashValue
    }
}

func ==<T, S>(lhs: Weak<T>, rhs: Weak<S>) -> Bool {
    return lhs.object === rhs.object
}

typealias WeakObject = Weak<AnyObject>
