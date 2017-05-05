//
//  CGError.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

enum CGError: Error {
    case complex
    case inexistent
    case infinity
}

protocol CGErrorProtocol {
    init(_ error: CGError)
}

extension CGError: CGErrorProtocol {
    init(_ error: CGError) {
        self = error
    }
}
