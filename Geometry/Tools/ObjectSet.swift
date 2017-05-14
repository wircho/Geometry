//
//  ObjectSet.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

// MARK: - ObjectSet

struct ObjectSet<T: AnyObject>: SetAlgebra {
    fileprivate var set: Set<HashableObject<T>>
    
    private init(set: Set<HashableObject<T>>) {
        self.set = set
    }
    
    init() {
        set = Set<HashableObject<T>>()
    }
    
    init<S : Sequence>(_ sequence: S) where S.Iterator.Element == T {
        set = Set(sequence.map { HashableObject($0) })
    }
    
    func union(_ other: [T]) -> ObjectSet<T> {
        return union(ObjectSet(other))
    }
    
    func intersection(_ other: [T]) -> ObjectSet<T> {
        return intersection(ObjectSet(other))
    }
    
    func contains(_ member: T) -> Bool {
        return set.contains(HashableObject(member))
    }
    
    func union(_ other: ObjectSet<T>) -> ObjectSet<T> {
        return ObjectSet<T>(set: set.union(other.set))
    }
    
    func intersection(_ other: ObjectSet<T>) -> ObjectSet<T> {
        return ObjectSet<T>(set: set.intersection(other.set))
    }
    
    func symmetricDifference(_ other: ObjectSet<T>) -> ObjectSet<T> {
        return ObjectSet<T>(set: set.symmetricDifference(other.set))
    }
    
    mutating func insert(_ newMember: T) -> (inserted: Bool, memberAfterInsert: T) {
        let result = set.insert(HashableObject(newMember))
        return (result.inserted, result.memberAfterInsert.object)
    }
    
    mutating func remove(_ member: T) -> T? {
        return set.remove(HashableObject(member))?.object
    }

    mutating func update(with newMember: T) -> T? {
        return set.update(with: HashableObject(newMember))?.object
    }
    
    mutating func formUnion(_ other: ObjectSet<T>) {
        set.formUnion(other.set)
    }
    
    mutating func formIntersection(_ other: ObjectSet<T>) {
        set.formIntersection(other.set)
    }
    
    mutating func formSymmetricDifference(_ other: ObjectSet<T>) {
        set.formSymmetricDifference(other.set)
    }
    
    func subtracting(_ other: ObjectSet<T>) -> ObjectSet<T> {
        return ObjectSet<T>(set: set.subtracting(other.set))
    }
    
    func isSubset(of other: ObjectSet<T>) -> Bool {
        return set.isSubset(of: other.set)
    }
    
    func isDisjoint(with other: ObjectSet<T>) -> Bool {
        return set.isDisjoint(with: other.set)
    }
    
    func isSuperset(of other: ObjectSet<T>) -> Bool {
        return set.isSuperset(of: other.set)
    }
    
    var isEmpty: Bool {
        return set.isEmpty
    }
    
    mutating func subtract(_ other: ObjectSet<T>) {
        set.subtract(other.set)
    }
    
    static func ==(lhs: ObjectSet<T>, rhs: ObjectSet<T>) -> Bool {
        return lhs.set == rhs.set
    }
    
    var array:[T] {
        return set.map { $0.object }
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
