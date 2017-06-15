//
//  LayerSkinnable+Selectable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-14.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics

extension SelectionState: Layer { }

protocol SelectionSkinnable: LayerSkinnable, Selectable {
    var normalSkin: SkinType { get }
    var selectedSkin: SkinType { get }
}

extension SelectionSkinnable where LayerType: SelectionStateProtocol {
    var visibleLayers: Set<LayerType> {
        return selected.booleanValue ? [._normal, ._selected] : [._normal]
    }
    
    func skin(for layer: LayerType) -> SkinType? {
        switch layer.state {
        case .normal: return normalSkin
        case .selected: return selectedSkin
        }
    }
}
