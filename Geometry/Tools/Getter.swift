//
//  Getter.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-03.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: Getter
// Not really using this. But it's nice.

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
