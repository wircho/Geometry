//
//  Selectable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

//protocol SelectionStateProtocol {
//    static var _normal: Self { get }
//    static var _selected: Self { get }
//    var state: SelectionState { get }
//}

protocol Selectable {
    var selected: Bool { get set }
}
