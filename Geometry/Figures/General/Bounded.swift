//
//  Bounded.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-19.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Bounded {
    associatedtype P: RawPointProtocol
    var startingPoint: AnyWeakFigure<P> { get }
    var endingPoint: AnyWeakFigure<P> { get }
}
