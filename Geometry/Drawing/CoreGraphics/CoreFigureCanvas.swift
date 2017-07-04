//
//  CoreFigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

final class CoreFigureCanvas: FigureCanvas {
    
    typealias PointStyleType = CorePointStyle
    typealias StrokeStyleType = CoreStrokeStyle
    
    weak var delegate: FigureCanvasDelegate? = nil
    
    let layers: [SelectionLayer] = [.normal, .selected]
    var elements: [AnyLayerDrawable<CGRect, SelectionLayer>] = []
    var points: [CoreStyleablePoint] = []
    var rulers: [CoreStyleableRuler] = []
    var circles: [CoreStyleableCircle] = []
    var arcs: [CoreStyleableArc] = []
    var curves: [CoreStyleableCurve] = []
    var quadCurves: [CoreStyleableQuadCurve] = []
}
