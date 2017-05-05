//
//  RawCache.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol RawCache: class {
    associatedtype Raw
    func getRaw() -> Raw
    var _raw: Raw { get set }
}
