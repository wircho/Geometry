//
//  ObjectSet.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: - ObjectSet

struct ObjectSet<T: AnyObject> {
    private(set) var set = Set<HashableObject<T>>()
    
    mutating func insert(_ newMember: T) -> (inserted: Bool, memberAfterInsert: T) {
        let result = set.insert(HashableObject(newMember))
        return (result.inserted, result.memberAfterInsert.object)
    }
    
    mutating func remove(_ newMember: T) -> T? {
        return set.remove(HashableObject(newMember))?.object
    }
    
}
    
// MARK: - ObjectSet: Collection

extension ObjectSet: Collection {
    
    var startIndex: SetIndex<HashableObject<T>> {
        return set.startIndex
    }
    
    var endIndex: SetIndex<HashableObject<T>> {
        return set.endIndex
    }
    
    subscript(position: SetIndex<HashableObject<T>>) -> T {
        return set[position].object
    }
    
    subscript(bounds: Range<SetIndex<HashableObject<T>>>) -> Slice<Set<HashableObject<T>>> {
        return set[bounds]
    }
    
    func index(after i: SetIndex<HashableObject<T>>) -> SetIndex<HashableObject<T>> {
        return set.index(after: i)
    }
    
    func formIndex(after i: inout SetIndex<HashableObject<T>>) {
        set.formIndex(after: &i)
    }
    
    var count: Int {
        return set.count
    }
    
}
