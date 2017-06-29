//
//  CoreStyleableRuler.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreStyleableRuler: SelectionStyleableFigure {
    typealias FigureValue = RawRuler<CGPoint>
    typealias StyleType = CoreStrokeStyle
    typealias RectType = CGRect
    typealias LayerType = SelectionLayer
    
    var selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>
    init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>) { self.selectionStyleableFigureStorage = selectionStyleableFigureStorage }
    
    func draw(in rect: CGRect, style: CoreStrokeStyle) {
        guard let ruler = self.weakFigure.result?.value, let exits = intersections(ruler, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? ruler.arrow.points.0,  exits.v1 ?? ruler.arrow.points.1)
        style.color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: style.lineWidth).stroke()
    }
}
