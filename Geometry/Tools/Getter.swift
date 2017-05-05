//
//  Getter.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: Getter

struct Getter<T> {
    private var getter: () -> T
    
    init(getter: @escaping () -> T) {
        self.getter = getter
    }
    
    var value: T {
        return getter()
    }
    
    func map<U>(_ transform: @escaping (T) -> U) -> Getter<U> {
        return Getter<U> { transform(self.getter()) }
    }
}

// MARK: Optionals

protocol OptionalProtocol {
    associatedtype W
    var optionalCopy: W? { get }
    init(optional: W?)
}

extension Optional: OptionalProtocol {
    typealias W = Wrapped
    init(optional: W?) { self = optional }
    var optionalCopy: Wrapped? { return self }
}

extension Getter where T: OptionalProtocol {
    func or(_ w:T.W) -> Getter<T.W> {
        return map { $0.optionalCopy ?? w }
    }
}

extension Getter where T: OptionalProtocol, T.W: AnyObject {
    init(weak object: T.W) {
        self.init { [weak object] in return T(optional: object) }
    }
}
