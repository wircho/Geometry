//
//  Arc.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Arc: FigureBase, OneDimensional, StrokeAppears, Drawable {
    var result: RawArcResult { get }
    var arcStorage: ArcStorage { get set }
}

extension Arc {
    func drawIn(_ rect: CGRect) {
        guard let value = result.value else { return }
        color.setStroke()
        UIBezierPath(arc: value, lineWidth: lineWidth).stroke()
    }
    
    func at(_ pos: Float) -> RawPoint? {
        guard let arc = result.value else { return nil }
        let angle: Float
        let angles = arc.angleValues
        if arc.fromFirst {
            angle = angles.v0 + (angles.v1 - angles.v0) * min(max(pos, 0), 1)
        } else {
            angle = angles.v1 + (angles.v0 - angles.v1) * min(max(pos, 0), 1)
        }
        return  arc.center + Angle(value: angle).vector(radius: arc.radius)
    }
    
    var cedula: Cedula {
        return arcStorage.cedula
    }
    
    var appearance: StrokeAppearance {
        get { return arcStorage.appearance }
        set { arcStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawArc> {
        get { return arcStorage.figureStorage }
        set { arcStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage {
        get { return arcStorage.oneDimensionalStorage }
        set { arcStorage.oneDimensionalStorage = newValue }
    }
}

struct ArcStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawArc>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
