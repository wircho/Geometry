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
