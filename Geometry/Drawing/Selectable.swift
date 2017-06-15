//
//  Selectable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol SelectionStateProtocol {
    static var _normal: Self { get }
    static var _selected: Self { get }
    var state: SelectionState { get }
}

enum SelectionState: SelectionStateProtocol {
    case normal
    case selected
    
    var booleanValue: Bool {
        return self == .selected
    }
    
    static var _normal: SelectionState { return .normal }
    static var _selected: SelectionState { return .selected }
    var state: SelectionState { return self }
}

protocol Selectable {
    var selected: SelectionState { get set }
}
