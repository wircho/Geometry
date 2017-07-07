//
//  LayerStyleable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol Style { }

protocol LayerStyleable /*: LayerDrawable*/ {
    associatedtype StyleType: Style
    associatedtype LayerType: Layer
    func style(for layer: LayerType) -> StyleType?
    func visible(on layer: LayerType) -> Bool
//    func draw(in rect: RectType, style: StyleType)
}

//extension LayerStyleable {
//    func draw(in rect: RectType, layer: LayerType) {
//        guard visible(on: layer), let style = style(for: layer) else { return }
//        draw(in: rect, style: style)
//    }
//}

//struct AnyLayerStyleable<R: RawRectProtocol, L: Layer, S: Style> {
//    //private var _drawOnLayer: (R, L) -> Void
//    private var _getStyle: (L) -> S?
//    private var _getVisible: (L) -> Bool?
//    
//    init<T: LayerStyleable>(_ figure: T) where /*T.RectType == R,*/ T.LayerType == L, T.StyleType == S {
//        //_drawOnLayer = { figure.draw(in: $0, layer: $1) }
//        _getStyle = { figure.style(for: $0) }
//        _getVisible = { figure.visible(on: $0) }
//    }
//    
////    func draw(in rect: R, layer: L) {
////        _drawOnLayer(rect, layer)
////    }
//    
//    func style(for layer: L) -> S? {
//        return _getStyle(layer)
//    }
//}
