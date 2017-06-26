//
//  FigureStyles.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol FigureColor { }

protocol FigureStyle: Style {
    static var `default`: Self { get }
}

protocol PointStyle: FigureStyle {
    associatedtype V: RawValueProtocol
    associatedtype C: FigureColor
    var diameter: V { get set }
    var color: C { get set }
}

extension PointStyle {
    var radius: V { return diameter / 2 }
}

protocol StrokeStyle: FigureStyle {
    associatedtype V: RawValueProtocol
    associatedtype C: FigureColor
    var lineWidth: V { get set }
    var color: C { get set }
}
