//
//  CoreFigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-18.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

typealias CoreStyleablePoint = SelectionStyleableFigure<CGPoint, CorePointStyle>
typealias CoreStyleableRuler = SelectionStyleableFigure<RawRuler<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableCircle = SelectionStyleableFigure<RawCircle<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableArc = SelectionStyleableFigure<RawArc<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableCurve = SelectionStyleableFigure<RawCurve<CGPoint>, CoreStrokeStyle>
typealias CoreStyleableQuadCurve = SelectionStyleableFigure<RawQuadCurve<CGPoint>, CoreStrokeStyle>

final class CoreFigureCanvas: TouchableFigureCanvas {
    
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
    
    func touchPriority(of figure: CoreStyleablePoint) -> CGFloat? { return 1000 }
    func touchPriority(of figure: CoreStyleableRuler) -> CGFloat? {
        guard let ruler = figure.weakFigure.result?.value else { return nil }
        switch ruler.kind {
        case .line: return 700
        case .ray: return 800
        case .segment: return 900
        }
    }
    func touchPriority(of figure: CoreStyleableCircle) -> CGFloat? { return 600 }
    func touchPriority(of figure: CoreStyleableArc) -> CGFloat? { return 850 }
    func touchPriority(of figure: CoreStyleableCurve) -> CGFloat? { return 600 }
    func touchPriority(of figure: CoreStyleableQuadCurve) -> CGFloat? { return 600 }
}
