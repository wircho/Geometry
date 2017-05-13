//
//  Association.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// A Swifty alternative to associated values
// ** All AnyObject associations are weak **


struct Association: Hashable {
    private let id: ObjectIdentifier
    private let key: String
    private static let queue = DispatchQueue(label: "associations")
    private static var strongDictionary = [Association: Any]()
    private static var weakDictionary = [Association: Weak<AnyObject>]()
    
    private init(_ object: AnyObject, _ key: String) {
        self.id = ObjectIdentifier(object)
        self.key = key
    }
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Association, rhs: Association) -> Bool {
        return lhs.id == rhs.id && lhs.key == rhs.key
    }
    
    private static func doRemove(_ object: AnyObject, _ key: String) {
        Association.strongDictionary[Association(object, key)] = nil
        Association.weakDictionary[Association(object, key)] = nil
    }
    
    private static func remove(_ object: AnyObject, _ key: String) {
        Association.queue.sync {
            doRemove(object, key)
        }
    }
    
    static func setWeak(_ object: AnyObject, _ key: String, _ val: AnyObject?) {
        Association.queue.sync {
            doRemove(object, key)
            guard let val = val else {
                return
            }
            Association.weakDictionary[Association(object, key)] = Weak<AnyObject>(val)
        }
    }
    
    static func setStrong(_ object: AnyObject, _ key: String, _ val: Any?) {
        Association.queue.sync {
            doRemove(object, key)
            guard let val = val else {
                return
            }
            Association.strongDictionary[Association(object, key)] = val
        }
    }
    
    static func getWeak(_ object: AnyObject, _ key: String) -> AnyObject? {
        return Association.queue.sync {
            return Association.weakDictionary[Association(object, key)]?.object
        }
    }
    
    static func getStrong(_ object: AnyObject, _ key: String) -> Any? {
        return Association.queue.sync {
            return Association.strongDictionary[Association(object, key)]
        }
    }
    
    static func clear(_ object: AnyObject) {
        return Association.queue.sync {
            let id = ObjectIdentifier(object)
            
            var weakSet = Set<Association>()
            for (assoc, _) in Association.weakDictionary {
                if assoc.id == id {
                    weakSet.insert(assoc)
                }
            }
            for assoc in weakSet {
                Association.weakDictionary[assoc] = nil
            }
            
            var strongSet = Set<Association>()
            for (assoc, _) in Association.strongDictionary {
                if assoc.id == id {
                    strongSet.insert(assoc)
                }
            }
            for assoc in strongSet {
                Association.strongDictionary[assoc] = nil
            }
        }
    }
}

