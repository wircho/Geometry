//
//  LayerSkinnable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

protocol Skin { }

protocol LayerSkinnable: LayerDrawable {
//    associatedtype Wrapped
    associatedtype SkinType: Skin
    func skin(for layer: LayerType) -> SkinType?
//    var wrapped: Wrapped? { get set }
    var visibleLayers: Set<LayerType> { get }
    func forceDraw(in rect: RectType, skin: SkinType)
}

extension LayerSkinnable {
    func draw(in rect: RectType, layer: LayerType) {
        guard visibleLayers.contains(layer), let skin = skin(for: layer) else { return }
        forceDraw(in: rect, skin: skin)
    }
    
//    var wrapsNone: Bool { return wrapped == nil }
}

//struct AnyLayerSkinnable<R: RawRectProtocol, L: Layer> {
//    private var _drawOnLayer: (R, L) -> Void
//    private var _isWrapedNone: () -> Bool
//    
//    init<S: LayerSkinnable>(_ skinnable: S) where S.RectType == R, S.LayerType == L {
//        _drawOnLayer = { skinnable.draw(in: $0, layer: $1) }
//        _isWrapedNone = { return skinnable.isWrappedNone }
//    }
//    
//    func draw(in rect: R, layer: L) {
//        _drawOnLayer(rect, layer)
//    }
//    
//    var isWrappedNone: Bool { return _isWrapedNone() }
//}
