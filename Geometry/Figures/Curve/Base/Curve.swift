//
//  Curve.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Curve: FigureBase, OneDimensional, StrokeAppears, Touchable {
    var result: Res<RawCurve> { get }
    var curveStorage: CurveStorage { get set }
}

extension Curve {
    func drawIn(_ rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(curve: value, lineWidth: appearance.lineWidth).stroke()
    }
    
    func at(_ pos: CGFloat) -> Res<RawPoint> {
        return result.map { $0.at(min(max(pos,0),1)) }
    }
    
    func nearest(from point: RawPoint) -> Res<CGFloat> {
        return result.map {
            curve in
            let p0 = curve.point0 - point
            let p1 = 3 * (curve.control0 - curve.point0)
            let p2 = 3 * (curve.point0 - 2 * curve.control0 + curve.control1)
            let p3 = -curve.point0 + 3 * curve.control0 - 3 * curve.control1 + curve.point1
            let d0 = p1
            let d1 = 2 * p2
            let d2 = 3 * p3
            let a0 = p0 • d0
            let a1 = p0 • d1 + p1 • d0
            let a2 = p0 • d2 + p1 • d1 + p2 • d0
            let a3 = p1 • d2 + p2 • d1 + p3 • d0
            let a4 = p2 • d2 + p3 • d1
            let a5 = p3 • d2
            let quintic = QuinticPolynomial(a0: a0, a1: a1, a2: a2, a3: a3, a4: a4, a5: a5)
            guard var roots = quintic.realRoots.array?.filter({ $0 >= 0 && $0 <= 1 }) else {
                return 0.5
            }
            roots += [0,1]
            var minDist: CGFloat? = nil
            var minRoot: CGFloat? = nil
            for root in roots {
                let near = curve.at(root)
                let dist = distance(point, near)
                if minDist.map({ $0 > dist }) ?? true {
                    minDist = dist
                    minRoot = root
                }
            }
            return min(max(minRoot ?? 0.5,0),1)
        }
    }
    
    var cedula: Cedula {
        return curveStorage.cedula
    }
    
    var appearance: StrokeAppearance {
        get { return curveStorage.appearance }
        set { curveStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawCurve> {
        get { return curveStorage.figureStorage }
        set { curveStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage {
        get { return curveStorage.oneDimensionalStorage }
        set { curveStorage.oneDimensionalStorage = newValue }
    }
    
    func gapToCenter(from point: RawPoint) -> Res<CGFloat> {
        return nearest(from: point).flatMap { distance(at($0), .success(point)) }
    }
    
    var touchPriority: CGFloat { return 600 }
}

struct CurveStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawCurve>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
