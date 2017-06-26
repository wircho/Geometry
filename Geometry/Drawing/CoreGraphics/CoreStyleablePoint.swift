//
//  CoreStyleablePoint.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-15.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreStyleablePoint: SelectionStyleableFigure {
    typealias FigureValue = CGPoint
    typealias StyleType = CorePointStyle
    typealias RectType = CGRect
    typealias LayerType = SelectionLayer
    
    var storage: SelectionStyleableFigureStorage<FigureValue, StyleType>
    init(storage: SelectionStyleableFigureStorage<FigureValue, StyleType>) { self.storage = storage }
    
    func draw(in rect: CGRect, style: CorePointStyle) {
        guard let center = self.weakFigure.result?.value else { return }
        style.color.setFill()
        UIBezierPath(circle: RawCircle(center: center, radius: style.radius)).fill()
    }
}
