//
//  FigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-23.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol FigureCanvasBase: class {
    var delegate: FigureCanvasDelegate? { get set }
}

extension FigureCanvasBase {
    func setAppearanceDidUpdate() {
        delegate?.appearanceDidUpdate(in: self)
    }
}

protocol FigureCanvas: FigureCanvasBase, LayerCanvas {
    associatedtype PointStyleType: PointStyle
    associatedtype StrokeStyleType: StrokeStyle
    
    associatedtype PointType: StyleInitiableFigure, LayerStyleableFigure
    associatedtype RulerType: StyleInitiableFigure, LayerStyleableFigure
    associatedtype CircleType: StyleInitiableFigure, LayerStyleableFigure
    associatedtype ArcType: StyleInitiableFigure, LayerStyleableFigure
    associatedtype CurveType: StyleInitiableFigure, LayerStyleableFigure
    associatedtype QuadCurveType: StyleInitiableFigure, LayerStyleableFigure
    
    var points: [PointType] { get set }
    var rulers: [RulerType] { get set }
    var circles: [CircleType] { get set }
    var arcs: [ArcType] { get set }
    var curves: [CurveType] { get set }
    var quadCurves: [QuadCurveType] { get set }
    
    // TODO: Make it so that styleable doesn't necessarily mean drawable.
    //       That way the figures above are not styleable. They'll probably not be touchable either. Let the canvas do the whole thing!
}

//extension FigureCanvas {
//    @discardableResult func add<T: LayerStyleableFigure>(_ figure: T) -> T where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == PointStyleType  {
//        elements.append(AnyLayerDrawable(figure))
//        points.append(AnyLayerStyleable(figure))
//        setAppearanceDidUpdate()
//        return figure
//    }
//    
//    @discardableResult func add<T: LayerStyleableFigure>(_ figure: T) -> T where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == StrokeStyleType  {
//        elements.append(AnyLayerDrawable(figure))
//        strokes.append(AnyLayerStyleable(figure))
//        setAppearanceDidUpdate()
//        return figure
//    }
//}

extension FigureCanvas where PointType.StyleType == PointStyleType, RulerType.StyleType == StrokeStyleType, CircleType.StyleType == StrokeStyleType, ArcType.StyleType == StrokeStyleType, CurveType.StyleType == StrokeStyleType, QuadCurveType.StyleType == StrokeStyleType, PointType.RectType == RectType, RulerType.RectType == RectType, CircleType.RectType == RectType, ArcType.RectType == RectType, CurveType.RectType == RectType, QuadCurveType.RectType == RectType, PointType.LayerType == LayerType, RulerType.LayerType == LayerType, CircleType.LayerType == LayerType, ArcType.LayerType == LayerType, CurveType.LayerType == LayerType, QuadCurveType.LayerType == LayerType {
    
    private func add<T: LayerDrawable>(_ figure: T, to array: inout [T]) -> T where T.RectType == RectType, T.LayerType == LayerType {
        array.append(figure)
        elements.append(AnyLayerDrawable(figure))
        return figure
    }
    
    @discardableResult func add<F: Point>(_ figure: F, style: PointStyleType = .default, hidden: Bool = false) -> PointType where F.ResultValue == Res<PointType.FigureValue> {
        return add(PointType(figure, style: style, hidden: hidden), to: &points)
    }
    
    @discardableResult func add<F: Ruler>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> RulerType where F.ResultValue == Res<RulerType.FigureValue> {
        return add(RulerType(figure, style: style, hidden: hidden), to: &rulers)
    }
    
    @discardableResult func add<F: Circle>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> CircleType where F.ResultValue == Res<CircleType.FigureValue> {
        return add(CircleType(figure, style: style, hidden: hidden), to: &circles)
    }
    
    @discardableResult func add<F: Arc>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> ArcType where F.ResultValue == Res<ArcType.FigureValue> {
        return add(ArcType(figure, style: style, hidden: hidden), to: &arcs)
    }
    
    @discardableResult func add<F: Curve>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> CurveType where F.ResultValue == Res<CurveType.FigureValue> {
        return add(CurveType(figure, style: style, hidden: hidden), to: &curves)
    }
    
    @discardableResult func add<F: QuadCurve>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> QuadCurveType where F.ResultValue == Res<QuadCurveType.FigureValue> {
        return add(QuadCurveType(figure, style: style, hidden: hidden), to: &quadCurves)
    }
}

protocol FigureCanvasDelegate: class {
    func appearanceDidUpdate(in canvas: FigureCanvasBase)
}