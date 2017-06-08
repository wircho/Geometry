//
//  Point.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Point: Figure, PointAppears, Touchable {
    associatedtype P: RawPointProtocol
    var pointStorage: PointStorage<P> { get set }
}

extension Point {
    func draw(in rect: CGRect, appearance: PointAppearance) {
        let cgResult = result as! Res<CGPoint>
        guard let center = cgResult.value else { return }
        appearance.color.setFill()
        UIBezierPath(circle: RawCircle(center: center, radius: appearance.radius)).fill()
    }
    
    var cedula: Cedula { return pointStorage.cedula }

    var appearance: PointAppearance {
        get { return pointStorage.appearance }
        set { pointStorage.appearance = newValue }
    }
 
    var storage: FigureStorage<P> {
        get { return pointStorage.figureStorage }
        set { pointStorage.figureStorage = newValue }
    }
    
    func gapToBorder(from point: CGPoint) -> Res<CGFloat> {
        let cgResult = result as! Res<CGPoint>
        return cgResult.map { max(0, distance($0, point)) }
    }
    
    var touchPriority: CGFloat { return 1000 }
 
}

struct PointStorage<P: RawPointProtocol> {
    let cedula = Cedula()
    var appearance = PointAppearance()
    var figureStorage = FigureStorage<P>()
}

// TODO: - Circumcenter, Baricenter, Point On object
// TODO: (Long term) Point In object
