//
//  Curve.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-17.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Result

protocol Curve: OneDimensional /*, StrokeAppears, Touchable*/ {
    associatedtype C: RawCurveProtocol
    var result: Res<C> { get }
    var curveStorage: CurveStorage<C> { get set }
}

extension Curve {
    /*func draw(in rect: CGRect, appearance: StrokeAppearance) {
        guard let value = result.value else { return }
        appearance.color.setStroke()
        UIBezierPath(curve: value, lineWidth: appearance.lineWidth).stroke()
    }*/
    
    func at(offset: C.Point.Value) -> Res<C.Point> {
        return result.map { $0.at(offset: min(max(offset,0),1)) }
    }
    
    func nearestOffset(from point: C.Point) -> Res<C.Point.Value> {
        return result.map {
            (curve: C) -> C.Point.Value in
            
            let p0 = curve.point0 - point
            let p1 = 3 * (curve.control0 - curve.point0)
            let p2_1 = -2 * curve.control0 + curve.control1
            let p2 = 3 * (curve.point0 + p2_1)
            let p3_c0 = 3 * curve.control0
            let p3_c1 = 3 * curve.control1
            let p3 = -curve.point0 + p3_c0 - p3_c1 + curve.point1
            let d0 = p1
            let d1 = 2 * p2
            let d2 = 3 * p3
            let a0 = p0 • d0
            let a1_0 = p0 • d1
            let a1_1 = p1 • d0
            let a1 = a1_0 + a1_1
            let a2_0 = p0 • d2
            let a2_1 = p1 • d1
            let a2_2 = p2 • d0
            let a2 = a2_0 + a2_1 + a2_2
            let a3_0 = p1 • d2
            let a3_1 = p2 • d1
            let a3_2 = p3 • d0
            let a3 = a3_0 + a3_1 + a3_2
            let a4_0 = p2 • d2
            let a4 = a4_0 + p3 • d1
            let a5 = p3 • d2
            let quintic = QuinticPolynomial(a0: a0, a1: a1, a2: a2, a3: a3, a4: a4, a5: a5)
            guard var roots = quintic.realRoots.array?.filter({ $0 >= 0 && $0 <= 1 }) else {
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
        return curveStorage.cedula
    }
    
   /* var appearance: StrokeAppearance {
        get { return curveStorage.appearance }
        set { curveStorage.appearance = newValue }
    }*/
    
    var storage: FigureStorage<C> {
        get { return curveStorage.figureStorage }
        set { curveStorage.figureStorage = newValue }
    }
    
    var oneDimensionalStorage: OneDimensionalStorage<C.Point> {
        get { return curveStorage.oneDimensionalStorage }
        set { curveStorage.oneDimensionalStorage = newValue }
    }
    
    func gap(from point: C.Point) -> Res<C.Point.Value> {
        return nearestOffset(from: point).flatMap { distance(at(offset: $0), .success(point)) }
    }
    
    /*var touchPriority: CGFloat { return 600 } */
}

struct CurveStorage<C: RawCurveProtocol> {
    let cedula = Cedula()
    /*var appearance = StrokeAppearance()*/
    var figureStorage = FigureStorage<C>()
    var oneDimensionalStorage = OneDimensionalStorage<C.Point>()
}
