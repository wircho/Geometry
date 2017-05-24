//
//  Line2Points.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-05.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

final class Line2Points<R: RawRulerProtocol>: Line, Ruler2PointsStandard {
    var ruler2PointsStorage: Ruler2PointsStorage<R>
    init(_ s: Ruler2PointsStorage<R>) { self.ruler2PointsStorage = s }
    
    // FIXING
//    var rulerStorage: RulerStorage<R> {
//        get { return  ruler2PointsStorage.rulerStorage }
//        set { ruler2PointsStorage.rulerStorage = newValue }
//    }
//    
    // END FIXING
    
    let parentOrder = ParentOrder.unsorted
    
    func at(offset: R.Arrow.Point.Value) -> Res<R.Arrow.Point> {
        fatalError()
        /*let x = result.map{
            (ruler: R) -> R.Arrow.Point.Value in
            let y = ruler.arrow.at(offset: offset)
            return y
        }
        return result.map { $0.arrow.at(offset: offset) }*/
    }
    
    func nearestOffset(from point: R.Arrow.Point) -> Res<R.Arrow.Point.Value> {
        fatalError()
        //return result.arrow.project(point)
    }
}
