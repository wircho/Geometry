//
//  Bounded.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-19.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol Bounded {
    associatedtype Endpoint: RawPointProtocol
    var startingPoint: AnyWeakFigure<Endpoint> { get }
    var endingPoint: AnyWeakFigure<Endpoint> { get }
}
