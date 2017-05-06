//
//  Tree.swift
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
    
    fileprivate static func with(sorted values: [T]) -> SimpleTree {
        guard let first = values.first else {
            return .empty
        }
        if values.count == 1 {
            return .leaf(first)
        } else {
            return .sorted(values.map{.leaf($0)})
        }
    }
    
    fileprivate static func with(unsorted values: [T]) -> SimpleTree {
        guard let first = values.first else {
            return .empty
        }
        if values.count == 1 {
            return .leaf(first)
        } else {
            return .unsorted(Set(values.map{.leaf($0)}))
        }
    }
    
    init (_ value: T) {
        self = .leaf(value)
    }
    
    init (sorted values: [T]) {
        self = .with(sorted: values)
    }
    
    init (unsorted values: [T]) {
        self = .with(unsorted: values)
    }
    
    init (sorted values: T ...) {
        self = .with(sorted: values)
    }
    
    init (unsorted values: T ...) {
        self = .with(unsorted: values)
    }
}

extension SimpleTree where T: WeakProtocol {
    typealias S = T.T
    
    init (_ value: S) {
        self = .leaf(T(value))
    }
    
    init (sorted values: [S]) {
        self = .with(sorted: values.map{ T($0) })
    }
    
    init (unsorted values: [S]) {
        self = .with(unsorted: values.map{ T($0) })
    }
    
    init (sorted values: S ...) {
        self = .with(sorted: values.map{ T($0) })
    }
    
    init (unsorted values: S ...) {
        self = .with(unsorted: values.map{ T($0) })
    }
}
