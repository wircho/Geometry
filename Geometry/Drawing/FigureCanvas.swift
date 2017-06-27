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
    
    associatedtype PointType: FigureStyleInitiable, LayerStyleableFigure
    associatedtype RulerType: FigureStyleInitiable, LayerStyleableFigure
    associatedtype CircleType: FigureStyleInitiable, LayerStyleableFigure
    associatedtype ArcType: FigureStyleInitiable, LayerStyleableFigure
    associatedtype CurveType: FigureStyleInitiable, LayerStyleableFigure
    associatedtype QuadCurveType: FigureStyleInitiable, LayerStyleableFigure
    
    var points: [AnyLayerStyleable<RectType, LayerType, PointStyleType>] { get set }
    var strokes: [AnyLayerStyleable<RectType, LayerType, StrokeStyleType>] { get set }
}

extension FigureCanvas {
    @discardableResult func add<T: LayerStyleableFigure>(_ figure: T) -> T where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == PointStyleType  {
        elements.append(AnyLayerDrawable(figure))
        points.append(AnyLayerStyleable(figure))
        setAppearanceDidUpdate()
        return figure
    }
    
    @discardableResult func add<T: LayerStyleableFigure>(_ figure: T) -> T where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == StrokeStyleType  {
        elements.append(AnyLayerDrawable(figure))
        strokes.append(AnyLayerStyleable(figure))
        setAppearanceDidUpdate()
        return figure
    }
}

extension FigureCanvas where PointType.StyleType == PointStyleType, RulerType.StyleType == StrokeStyleType, CircleType.StyleType == StrokeStyleType, ArcType.StyleType == StrokeStyleType, CurveType.StyleType == StrokeStyleType, QuadCurveType.StyleType == StrokeStyleType, PointType.RectType == RectType, RulerType.RectType == RectType, CircleType.RectType == RectType, ArcType.RectType == RectType, CurveType.RectType == RectType, QuadCurveType.RectType == RectType, PointType.LayerType == LayerType, RulerType.LayerType == LayerType, CircleType.LayerType == LayerType, ArcType.LayerType == LayerType, CurveType.LayerType == LayerType, QuadCurveType.LayerType == LayerType {
    
    @discardableResult func add<F: Figure>(_ figure: F, style: PointStyleType = .default, hidden: Bool = false) -> PointType where F.ResultValue == Res<PointType.FigureValue> {
        return add(PointType(figure, style: style, hidden: hidden))
    }
    
    @discardableResult func add<F: Figure>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> RulerType where F.ResultValue == Res<RulerType.FigureValue> {
        return add(RulerType(figure, style: style, hidden: hidden))
    }
    
    @discardableResult func add<F: Figure>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> CircleType where F.ResultValue == Res<CircleType.FigureValue> {
        return add(CircleType(figure, style: style, hidden: hidden))
    }
    
    @discardableResult func add<F: Figure>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> ArcType where F.ResultValue == Res<ArcType.FigureValue> {
        return add(ArcType(figure, style: style, hidden: hidden))
    }
    
    @discardableResult func add<F: Figure>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> CurveType where F.ResultValue == Res<CurveType.FigureValue> {
        return add(CurveType(figure, style: style, hidden: hidden))
    }
    
    @discardableResult func add<F: Figure>(_ figure: F, style: StrokeStyleType = .default, hidden: Bool = false) -> QuadCurveType where F.ResultValue == Res<QuadCurveType.FigureValue> {
        return add(QuadCurveType(figure, style: style, hidden: hidden))
    }
}

protocol FigureCanvasDelegate: class {
    func appearanceDidUpdate(in canvas: FigureCanvasBase)
}
