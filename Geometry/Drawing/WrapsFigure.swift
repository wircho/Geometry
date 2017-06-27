//
//  WrapsFigure.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol WrapsFigure: class {
    associatedtype FigureValue
    var weakFigure: AnyWeakFigure<FigureValue> { get }
}
