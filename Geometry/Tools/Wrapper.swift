//
//  Wrapper.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol Wrapper {
    associatedtype Wrapped
    var wrapped: Wrapped { get }
}

extension Wrapper where Wrapped: OptionalProtocol {
    var wrapsNone: Bool { return wrapped.optionalCopy == nil }
}
