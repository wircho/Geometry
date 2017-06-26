//
//  LayerStyleableFigure.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-21.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol LayerStyleableFigure: LayerStyleable, LayerDrawableFigure {
    
}

struct AnyLayerStyleableFigure<R: RawRectProtocol, L: Layer, S: Style, FV> {
    private var _drawOnLayer: (R, L) -> Void
    private var _getStyle: (L) -> S?
    private var _getVisible: (L) -> Bool?
    private var _getWeakFigure: () -> AnyWeakFigure<FV>
    
    init<T: LayerStyleableFigure>(_ figure: T) where T.RectType == R, T.LayerType == L, T.StyleType == S, T.FigureValue == FV {
        _drawOnLayer = { figure.draw(in: $0, layer: $1) }
        _getStyle = { figure.style(for: $0) }
        _getVisible = { figure.visible(on: $0) }
        _getWeakFigure = { figure.weakFigure }
    }
    
    func draw(in rect: R, layer: L) {
        _drawOnLayer(rect, layer)
    }
    
    func style(for layer: L) -> S? {
        return _getStyle(layer)
    }
    
    var weakFigure: AnyWeakFigure<FV> { return _getWeakFigure() }
}
