//
//  QuadCurve.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol QuadCurve: FigureBase, OneDimensional, StrokeAppears, Touchable {
    var result: Res<RawQuadCurve> { get }
    var quadCurveStorage: QuadCurveStorage { get set }
}

extension QuadCurve {
    func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(quadCurve: value, lineWidth: appearance.lineWidth).stroke()
    }
    
    func at(_ pos: CGFloat) -> Res<RawPoint> {
        return result.map { $0.at(min(max(pos,0),1)) }
    }
    
    func nearest(from point: RawPoint) -> Res<CGFloat> {
        return result.map {
            curve in
            let p0 = curve.point0 - point
            let p1 = 2 * (curve.control - curve.point0)
            let p2 = curve.point0 - 2 * curve.control + curve.point1
            let d0 = p1
            let d1 = 2 * p2
            let a0 = p0 • d0
            let a1 = p0 • d1 + p1 • d0
            let a2 = p1 • d1 + p2 • d0
            let a3 = p2 • d1
            let cubic = CubicPolynomial(a0: a0, a1: a1, a2: a2, a3: a3)
            guard var roots = cubic.realRoots.array?.filter({ $0 >= 0 && $0 <= 1 }) else {
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
        return quadCurveStorage.cedula
    }
    
    var appearance: StrokeAppearance {
        get { return quadCurveStorage.appearance }
        set { quadCurveStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawQuadCurve> {
        get { return quadCurveStorage.figureStorage }
        set { quadCurveStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage {
        get { return quadCurveStorage.oneDimensionalStorage }
        set { quadCurveStorage.oneDimensionalStorage = newValue }
    }
    
    func gapToCenter(from point: RawPoint) -> Res<CGFloat> {
        return nearest(from: point).flatMap { distance(at($0), .success(point)) }
    }
    
    var touchPriority: CGFloat { return 600 }
}

struct QuadCurveStorage {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<RawQuadCurve>()
    var oneDimensionalStorage = OneDimensionalStorage()
}
