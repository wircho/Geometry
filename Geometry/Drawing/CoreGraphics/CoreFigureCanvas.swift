//
//  CoreFigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreFigureCanvas: FigureCanvas {
    
    typealias PointType = CoreStyleablePoint
    typealias RulerType = CoreStyleableRuler
    typealias CircleType = CoreStyleableCircle
    typealias ArcType = CoreStyleableArc
    typealias CurveType = CoreStyleableCurve
    typealias QuadCurveType = CoreStyleableQuadCurve
    
    let layers: [SelectionLayer] = [.normal, .selected]
    var elements: [AnyLayerDrawable<CGRect, SelectionLayer>] = []
    var points: [AnyLayerStyleable<CGRect, SelectionLayer, CorePointStyle>] = []
    var strokes: [AnyLayerStyleable<CGRect, SelectionLayer, CoreStrokeStyle>] = []
}
