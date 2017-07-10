//
//  TouchableFigureCanvas.swift
//  GeometrySample
//
//  Created by Adolfo Rodriguez on 2017-06-29.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol TouchableFigureCanvas: FigureCanvas {
    associatedtype TouchPriorityType: RawValueProtocol
    
    func touchPriority(of figure: PointType) -> TouchPriorityType?
    func touchPriority(of figure: RulerType) -> TouchPriorityType?
    func touchPriority(of figure: CircleType) -> TouchPriorityType?
    func touchPriority(of figure: ArcType) -> TouchPriorityType?
    func touchPriority(of figure: CurveType) -> TouchPriorityType?
    func touchPriority(of figure: QuadCurveType) -> TouchPriorityType?
}
