//
//  Point.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Point: FigureBase, PointAppears, Touchable {
    var result: RawPointResult { get }
    var pointStorage: PointStorage { get set }
}

extension Point {
    func drawIn(_ rect: CGRect, appearance: PointAppearance) {
        guard let center = result.value else { return }
        appearance.color.setFill()
        UIBezierPath(circle: RawCircle(center: center, radius: appearance.radius)).fill()
    }
    
    var cedula: Cedula { return pointStorage.cedula }
    
    var appearance: PointAppearance {
        get { return pointStorage.appearance }
        set { pointStorage.appearance = newValue }
    }
    
    var storage: FigureStorage<RawPoint> {
        get { return pointStorage.figureStorage }
        set { pointStorage.figureStorage = newValue }
    }
    
    func gap(from point: RawPoint) -> FloatResult {
        return result.map { distance($0, point) }
    }
    
    var touchPriority: Float { return 1000 }
}

struct PointStorage {
    let cedula = Cedula()
    var appearance = PointAppearance()
    var figureStorage = FigureStorage<RawPoint>()
}

// TODO: - Circumcenter, Baricenter, Point On object
// TODO: (Long term) Point In object
