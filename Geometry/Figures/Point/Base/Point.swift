//
//  Point.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

protocol Point: Figure {
    associatedtype P: RawPointProtocol
    var result: Res<P> { get }
    var pointStorage: PointStorage<P> { get set }
}

extension Point {
   /* func draw(in rect: CGRect, appearance: PointAppearance) {
        guard let center = result.value else { return }
        appearance.color.setFill()
        UIBezierPath(circle: RawCircle(center: center, radius: appearance.radius)).fill()
    }
    */
    
    var cedula: Cedula { return pointStorage.cedula }
  /*
    var appearance: PointAppearance {
        get { return pointStorage.appearance }
        set { pointStorage.appearance = newValue }
    }
    
 */
    var storage: FigureStorage<P> {
        get { return pointStorage.figureStorage }
        set { pointStorage.figureStorage = newValue }
    }
  /*
    func gap(from point: P) -> Res<P.V> {
        return result.map { distance($0, point) }
    }
    
    var touchPriority: CGFloat { return 1000 }
 
 */
}

struct PointStorage<P: RawPointProtocol> {
    let cedula = Cedula()
    /*var appearance = PointAppearance()*/
    var figureStorage = FigureStorage<P>()
}

// TODO: - Circumcenter, Baricenter, Point On object
// TODO: (Long term) Point In object
