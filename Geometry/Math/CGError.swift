//
//  CGError.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

enum CGError: Error {
    case none
    case complex
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
