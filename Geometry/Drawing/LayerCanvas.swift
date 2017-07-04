//
//  LayerCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol LayerCanvas: class, Drawable, LayerDrawable {
    associatedtype RectType: RawRectProtocol
    associatedtype LayerType: Layer
    var layers: [LayerType] { get }
    var elements: [AnyLayerDrawable<RectType, LayerType>] { get set }
}

extension LayerCanvas {
    func draw(in rect: RectType, layer: LayerType) {
        for element in elements {
            element.draw(in: rect, layer: layer)
        }
    }
    
    func draw(in rect: RectType) {
        for layer in layers {
            draw(in: rect, layer: layer)
        }
    }
    
    private func add(_ element: AnyLayerDrawable<RectType, LayerType>) {
        elements.append(element)
    }
    
    func add<T: LayerDrawable>(drawable element: T) where T.RectType == RectType, T.LayerType == LayerType {
        add(AnyLayerDrawable(element))
    }
}
