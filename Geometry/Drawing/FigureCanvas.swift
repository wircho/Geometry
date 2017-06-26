//
//  FigureCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-23.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol FigureCanvas: LayerCanvas {
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
    func add<T: LayerStyleableFigure>(_ figure: T) where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == PointStyleType  {
        elements.append(AnyLayerDrawable(figure))
        points.append(AnyLayerStyleable(figure))
    }
    
    func add<T: LayerStyleableFigure>(_ figure: T) where T.RectType == RectType, T.LayerType == LayerType, T.StyleType == StrokeStyleType  {
        elements.append(AnyLayerDrawable(figure))
        strokes.append(AnyLayerStyleable(figure))
    }
}

extension FigureCanvas where PointType.StyleType == PointStyleType, RulerType.StyleType == StrokeStyleType, CircleType.StyleType == StrokeStyleType, ArcType.StyleType == StrokeStyleType, CurveType.StyleType == StrokeStyleType, QuadCurveType.StyleType == StrokeStyleType, PointType.RectType == RectType, RulerType.RectType == RectType, CircleType.RectType == RectType, ArcType.RectType == RectType, CurveType.RectType == RectType, QuadCurveType.RectType == RectType, PointType.LayerType == LayerType, RulerType.LayerType == LayerType, CircleType.LayerType == LayerType, ArcType.LayerType == LayerType, CurveType.LayerType == LayerType, QuadCurveType.LayerType == LayerType {
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<PointType.FigureValue> {
        add(PointType(figure))
    }
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<RulerType.FigureValue> {
        add(RulerType(figure))
    }
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<CircleType.FigureValue> {
        add(CircleType(figure))
    }
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<ArcType.FigureValue> {
        add(ArcType(figure))
    }
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<CurveType.FigureValue> {
        add(CurveType(figure))
    }
    
    func add<F: Figure>(_ figure: F) where F.ResultValue == Res<QuadCurveType.FigureValue> {
        add(QuadCurveType(figure))
    }
    
    func add<F: Figure>(_ figure: F, style: PointStyleType) where F.ResultValue == Res<PointType.FigureValue> {
        add(PointType(figure, style: style))
    }
    
    func add<F: Figure>(_ figure: F, style: StrokeStyleType) where F.ResultValue == Res<RulerType.FigureValue> {
        add(RulerType(figure, style: style))
    }
    
    func add<F: Figure>(_ figure: F, style: StrokeStyleType) where F.ResultValue == Res<CircleType.FigureValue> {
        add(CircleType(figure, style: style))
    }
    
    func add<F: Figure>(_ figure: F, style: StrokeStyleType) where F.ResultValue == Res<ArcType.FigureValue> {
        add(ArcType(figure, style: style))
    }
    
    func add<F: Figure>(_ figure: F, style: StrokeStyleType) where F.ResultValue == Res<CurveType.FigureValue> {
        add(CurveType(figure, style: style))
    }
    
    func add<F: Figure>(_ figure: F, style: StrokeStyleType) where F.ResultValue == Res<QuadCurveType.FigureValue> {
        add(QuadCurveType(figure, style: style))
    }
}
