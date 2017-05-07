//
//  MathError.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

enum MathError: Error {
    case none
    case complex
    case infinity
}

protocol MathErrorProtocol {
    init(_ error: MathError)
}

extension MathError: MathErrorProtocol {
    init(_ error: MathError) {
        self = error
    }
}
