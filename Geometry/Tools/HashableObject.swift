//
//  HashableObject.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

struct HashableObject<T: AnyObject>: Hashable {
    private(set) var object: T
    
    var hashValue: Int {
        return ObjectIdentifier(object).hashValue
    }
    
    init(_ object: T) {
        self.object = object
    }
    
    static func ==(lhs: HashableObject, rhs: HashableObject) -> Bool {
        return lhs.object === rhs.object
    }
}
