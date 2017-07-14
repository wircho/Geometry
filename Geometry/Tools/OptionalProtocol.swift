//
//  OptionalProtocol.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-08.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: - OptionalProtocol

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

// MARK: - Double optional

extension OptionalProtocol where W: OptionalProtocol {
    var optional: W.W? {
        guard let s = self.optionalCopy,  let w = s.optionalCopy else {
            return nil
        }
        return w
    }
}

//// MARK: - Result
//
//extension Result where T: OptionalProtocol {
//    var optional: Result<T.W, Error>? {
//        return analysis(ifSuccess: {
//            guard let value = $0.optionalCopy else { return nil }
//            return .success(value)
//        }, ifFailure: {
//            return .failure($0)
//        })
//    }
//}

