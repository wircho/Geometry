//
//  Arc.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-11.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Arc: FigureBase, OneDimensional, StrokeAppears, Touchable {
    var result: Res<RawArc> { get }
    var arcStorage: ArcStorage { get set }
}

extension Arc {
    func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(arc: value, lineWidth: appearance.lineWidth).stroke()
    }
    
    func at(offset: CGFloat) -> Res<RawPoint> {
        return result.map {
            arc in
            let angle: CGFloat
            let angles = arc.angleValues
            if arc.fromFirst {
                angle = angles.v0 + (angles.v1 - angles.v0) * min(max(pos, 0), 1)
            } else {
                angle = angles.v1 + (angles.v0 - angles.v1) * min(max(pos, 0), 1)
            }
            return  arc.center + Angle(value: angle).vector(radius: arc.radius)
        }
    }
    
    func nearestOffset(from point: RawPoint) -> Res<CGFloat> {
        return result.flatMap {
            arc in
            var angles = arc.angleValues
            let angle = arc.angles.v0.greaterValue((point - arc.center).angle)
            if angle <= angles.v1 {
                return arc.fromFirst ? ((angle - angles.v0) ~/ (angles.v1 - angles.v0)) : ((angles.v1 - angle) ~/ (angles.v1 - angles.v0))
            } else {
                angles.v0 += Angle.twoPiValue
                if (abs(angle - angles.v1) < abs(angles.v0 - angle)) == arc.fromFirst {
                    return .success(1)
                } else {
                    return .success(0)
                }
            }
        }
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
    
    func gap(from point: RawPoint) -> Res<CGFloat> {
        return result.flatMap {
            arc in
            nearestOffset(from: point).map {
                c in
                let angleValues = arc.angleValues
                let angle = angleValues.v0 + (angleValues.v1 - angleValues.v0) * (arc.fromFirst ? c : (1 - c))
                return distance(point, arc.center + Angle(value: angle).vector(radius: arc.radius))
            }
        }
    }
    
    var touchPriority: CGFloat { return 850 }
}

struct ArcStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawArc>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
