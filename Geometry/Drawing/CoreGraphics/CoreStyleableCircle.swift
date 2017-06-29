//
//  CoreStyleableCircle.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreStyleableCircle: SelectionStyleableFigure {
    typealias FigureValue = RawCircle<CGPoint>
    typealias StyleType = CoreStrokeStyle
    typealias RectType = CGRect
    typealias LayerType = SelectionLayer
    
    var selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>
    init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>) { self.selectionStyleableFigureStorage = selectionStyleableFigureStorage }
    
    func draw(in rect: CGRect, style: CoreStrokeStyle) {
        guard let circle = self.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(circle: circle, lineWidth: style.lineWidth).stroke()
    }
}
