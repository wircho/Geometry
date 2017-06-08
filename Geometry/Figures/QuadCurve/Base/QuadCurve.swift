//
//  QuadCurve.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol QuadCurve: OneDimensional, StrokeAppears, Touchable {
    associatedtype C: RawQuadCurveProtocol
    var result: Res<C> { get }
    var quadCurveStorage: QuadCurveStorage<C> { get set }
}

extension QuadCurve {
    func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        let cgValue = value as! RawQuadCurve<CGPoint>
        appearance.color.setStroke()
        UIBezierPath(quadCurve: cgValue, lineWidth: appearance.lineWidth).stroke()
    }
    
    func at(offset: C.Point.Value) -> Res<C.Point> {
        return result.map { $0.at(offset: min(max(offset,0),1)) }
    }
    
    func nearestOffset(from point: C.Point) -> Res<C.Point.Value> {
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
                return 1/2
            }
            roots += [0,1]
            var minDist: C.Point.Value? = nil
            var minRoot: C.Point.Value? = nil
            for root in roots {
                let near = curve.at(offset: root)
                let dist = distance(point, near)
                if minDist.map({ $0 > dist }) ?? true {
                    minDist = dist
                    minRoot = root
                }
            }
            return min(max(minRoot ?? 1/2,0),1)
        }
    }
    
    var cedula: Cedula {
        return quadCurveStorage.cedula
    }
    
    var appearance: StrokeAppearance {
        get { return quadCurveStorage.appearance }
        set { quadCurveStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<C> {
        get { return quadCurveStorage.figureStorage }
        set { quadCurveStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage<C.Point> {
        get { return quadCurveStorage.oneDimensionalStorage }
        set { quadCurveStorage.oneDimensionalStorage = newValue }
    }
    
    func gap(from point: C.Point) -> Res<C.Point.Value> {
        return nearestOffset(from: point).flatMap { distance(at(offset: $0), .success(point)) }
    }
    
    var touchPriority: CGFloat { return 600 }
}

struct QuadCurveStorage<C: RawQuadCurveProtocol> {
    let cedula = Cedula()
    var appearance = StrokeAppearance()
    var figureStorage = FigureStorage<C>()
    var oneDimensionalStorage = OneDimensionalStorage<C.Point>()
}
