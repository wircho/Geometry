//
//  ParentComparable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

enum ParentOrder {
    case sorted
    case unsorted
}

protocol ParentComparable {
    var parents: [AnyObject?] { get }
    var parentOrder: ParentOrder { get }
}

extension ParentComparable {
    func compare(with other: Self) -> Bool {
        switch parentOrder {
        case .sorted:
            return ObjectSet<AnyObject>.compareWholeArrays(parents, other.parents)
        case .unsorted:
            return ObjectSet<AnyObject>.compareWholeSets(parents, other.parents)
        }
    }
}
