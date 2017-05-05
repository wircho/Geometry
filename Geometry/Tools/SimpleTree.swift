//
//  Tree.swift
//  Drawvy
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

enum SimpleTree<T: Hashable>: Hashable {
    case empty
    case leaf(T)
    case sorted([SimpleTree<T>])
    case unsorted(Set<SimpleTree<T>>)
    
    var hashValue: Int {
        switch self {
        case .empty:
            return 0
        case .leaf(let t):
            return t.hashValue
        case .sorted(let array):
            return array.map{ $0.hashValue }.reduce(0, ^)
        case .unsorted(let set):
            return set.map{ $0.hashValue }.reduce(0, ^)
        }
    }
    
    static func ==(lhs: SimpleTree, rhs: SimpleTree) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case let (.leaf(t0), .leaf(t1)):
            return t0 == t1
        case let (.sorted(array0), .sorted(array1)):
            return array0 == array1
        case let (.unsorted(set0), .unsorted(set1)):
            return set0 == set1
        default:
            return false
        }
    }
    
    init (_ value: T) {
        self = .leaf(value)
    }
    
    init (_ value0: T, _ value1: T) {
        self = .sorted([.leaf(value0), .leaf(value1)])
    }
    
    init (_ value0: T, _ value1: T, _ value2: T) {
        self = .sorted([.leaf(value0), .leaf(value1), .leaf(value2)])
    }
    
    init (unsorted value0: T, _ value1: T) {
        self = .unsorted([.leaf(value0), .leaf(value1)])
    }
    
    init (unsorted value0: T, _ value1: T, _ value2: T) {
        self = .unsorted([.leaf(value0), .leaf(value1), .leaf(value2)])
    }
    
    init (_ array: [T]) {
        self = .sorted(array.map{.leaf($0)})
    }
    
    init (sorted array: [T]) {
        self = .sorted(array.map{.leaf($0)})
    }
    
    init (unsorted set: Set<T>) {
        self = .unsorted(Set(set.map{.leaf($0)}))
    }
}

extension SimpleTree where T: WeakProtocol {
    typealias S = T.T
    
    init (_ value: S) {
        self = .leaf(T(value))
    }
    
    init (_ value0: S, _ value1: S) {
        self = .sorted([.leaf(T(value0)), .leaf(T(value1))])
    }
    
    init (_ value0: S, _ value1: S, _ value2: S) {
        self = .sorted([.leaf(T(value0)), .leaf(T(value1)), .leaf(T(value2))])
    }
    
    init (unsorted value0: S, _ value1: S) {
        self = .unsorted([.leaf(T(value0)), .leaf(T(value1))])
    }
    
    init (unsorted value0: S, _ value1: S, _ value2: S) {
        self = .unsorted([.leaf(T(value0)), .leaf(T(value1)), .leaf(T(value2))])
    }
    
    init (_ array: [S]) {
        self = .sorted(array.map{.leaf(T($0))})
    }
    
    init (sorted array: [S]) {
        self = .sorted(array.map{.leaf(T($0))})
    }
    
    init (unsorted array: [S]) {
        self = .unsorted(Set(array.map{.leaf(T($0))}))
    }
}
