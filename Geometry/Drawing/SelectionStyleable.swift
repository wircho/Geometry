//
//  LayerStyleable+Selectable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//


enum SelectionLayer: Layer {
    case normal
    case selected
}

protocol SelectionStyleable: LayerStyleable, Selectable, Hideable {
    var style: StyleType { get set }
    var selectedStyle: StyleType { get }
}

extension SelectionStyleable where LayerType == SelectionLayer {
    func visible(on layer: LayerType) -> Bool {
        return !hidden && (layer == .normal || selected)
    }
    
    func style(for layer: LayerType) -> StyleType? {
        switch layer {
        case .normal: return style
        case .selected: return selectedStyle
        }
    }
}

