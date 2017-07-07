//
//  LayerDrawable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol Layer: Hashable { }

protocol LayerDrawable {
    associatedtype RectType: RawRectProtocol
    associatedtype LayerType: Layer
    func draw(in rect: RectType, layer: LayerType)
}

struct AnyLayerDrawable<R: RawRectProtocol, L: Layer> {
    private let _drawOnLayer: (R, L) -> Void
    
    init(drawOnLayer: @escaping (R, L) -> Void) {
        _drawOnLayer = drawOnLayer
    }
    
    init<T: LayerDrawable>(_ styleable: T) where T.RectType == R, T.LayerType == L {
        self.init { styleable.draw(in: $0, layer: $1) }
    }
    
    func draw(in rect: R, layer: L) {
        _drawOnLayer(rect, layer)
    }
}
