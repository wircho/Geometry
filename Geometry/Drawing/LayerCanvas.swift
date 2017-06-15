//
//  LayerCanvas.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation

//enum DrawableOrSkinnable<R: RawRectProtocol, L: Layer>: LayerDrawable {
//    case drawable(AnyDrawable<R>, L)
//    case skinnable(AnySkinnable<R, L>)
//    
//    func draw(in rect: R, layer: L) {
//        switch self {
//        case .drawable(let d, let dLayer):
//            guard dLayer == layer else { return }
//            d.draw(in: rect)
//        case .skinnable(let s):
//            s.draw(in: rect, layer: layer)
//        }
//    }
//}

protocol LayerCanvas: class, Drawable, LayerDrawable {
    associatedtype LayerSkinnableType: LayerSkinnable
    var layers:[LayerSkinnableType.LayerType] { get }
    var elements: [LayerSkinnableType] { get set }
}

extension LayerCanvas {
//    func trim() {
//        figures = figures.filter {
//            figure in
//            guard case .skinnable(let s) = figure else { return true }
//            return !s.isWrappedNone
//        }
//    }
//    
    func draw(in rect: LayerSkinnableType.RectType, layer: LayerSkinnableType.LayerType) {
        for element in elements {
            element.draw(in: rect, layer: layer)
        }
    }
    
    func draw(in rect: LayerSkinnableType.RectType) {
        for layer in layers {
            draw(in: rect, layer: layer)
        }
    }
    
//    func append<S: Skinnable>(_ figure: S) where S.RectType == RectType, S.LayerType == LayerType {
//        figures.append(.skinnable(AnySkinnable(figure)))
//    }
//    
//    func append<D: Drawable>(_ figure: D, layer: LayerType) where D.RectType == RectType {
//        figures.append(.drawable(AnyDrawable(figure), layer))
//    }
}
