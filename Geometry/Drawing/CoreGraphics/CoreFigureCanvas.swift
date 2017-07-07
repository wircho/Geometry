//
//  CoreFigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

typealias CoreStyleablePoint = CoreStyleableFigure<CGPoint, CorePointStyle>
typealias CoreStyleableRuler = CoreStyleableFigure<RawRuler<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableCircle = CoreStyleableFigure<RawCircle<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableArc = CoreStyleableFigure<RawArc<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableCurve = CoreStyleableFigure<RawCurve<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableQuadCurve = CoreStyleableFigure<RawQuadCurve<CGPoint>, CoreStrokeStyle>

final class CoreFigureCanvas: FigureCanvas {
    
    weak var delegate: FigureCanvasDelegate? = nil
    
    let layers: [SelectionLayer] = [.normal, .selected]
    var elements: [AnyLayerDrawable<CGRect, SelectionLayer>] = []
    var points: [CoreStyleablePoint] = []
    var rulers: [CoreStyleableRuler] = []
    var circles: [CoreStyleableCircle] = []
    var arcs: [CoreStyleableArc] = []
    var curves: [CoreStyleableCurve] = []
    var quadCurves: [CoreStyleableQuadCurve] = []
    
    func draw(_ figure: CoreStyleablePoint, in rect: CGRect, style: CorePointStyle) {
        guard let center = figure.weakFigure.result?.value else { return }
        style.color.setFill()
        UIBezierPath(circle: RawCircle(center: center, radius: style.radius)).fill()
    }
    
    func draw(_ figure: CoreStyleableRuler, in rect: CGRect, style: CoreStrokeStyle) {
        guard let ruler = figure.weakFigure.result?.value, let exits = intersections(ruler, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? ruler.arrow.points.0,  exits.v1 ?? ruler.arrow.points.1)
        style.color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: style.lineWidth).stroke()
    }
    
    func draw(_ figure: CoreStyleableCircle, in rect: CGRect, style: CoreStrokeStyle) {
        guard let circle = figure.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(circle: circle, lineWidth: style.lineWidth).stroke()
    }
    
    func draw(_ figure: CoreStyleableArc, in rect: CGRect, style: CoreStrokeStyle) {
        guard let arc = figure.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(arc: arc, lineWidth: style.lineWidth).stroke()
    }
    
    func draw(_ figure: CoreStyleableCurve, in rect: CGRect, style: CoreStrokeStyle) {
        guard let curve = figure.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(curve: curve, lineWidth: style.lineWidth).stroke()
    }
    
    func draw(_ figure: CoreStyleableQuadCurve, in rect: CGRect, style: CoreStrokeStyle) {
        guard let quadCurve = figure.weakFigure.result?.value else { return }
        style.color.setStroke()
        UIBezierPath(quadCurve: quadCurve, lineWidth: style.lineWidth).stroke()
    }
}
