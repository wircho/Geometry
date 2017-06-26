//
//  CoreStyleableArc.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreStyleableArc: SelectionStyleableFigure {
    typealias FigureValue = RawArc<CGPoint>
    typealias StyleType = CoreStrokeStyle
    typealias RectType = CGRect
    typealias LayerType = SelectionLayer
    
    var storage: SelectionStyleableFigureStorage<FigureValue, StyleType>
    init(storage: SelectionStyleableFigureStorage<FigureValue, StyleType>) { self.storage = storage }
    
    func draw(in rect: CGRect, style: CoreStrokeStyle) {
        guard let arc = self.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(arc: arc, lineWidth: style.lineWidth).stroke()
    }
}
