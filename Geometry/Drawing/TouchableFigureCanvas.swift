//
//  TouchableFigureCanvas.swift
//  GeometrySample
//
//  Created by Adolfo Rodriguez on 2017-06-29.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol TouchableFigureCanvas: FigureCanvas {
    associatedtype TouchPointType: RawPointProtocol
    
    func touchPriority(of figure: PointType) -> TouchPointType.Value
    func touchPriority(of figure: RulerType) -> TouchPointType.Value
    func touchPriority(of figure: CircleType) -> TouchPointType.Value
    func touchPriority(of figure: ArcType) -> TouchPointType.Value
    func touchPriority(of figure: CurveType) -> TouchPointType.Value
    func touchPriority(of figure: QuadCurveType) -> TouchPointType.Value
    
    func gap(from point: TouchPointType, to figure: PointType) -> Res<TouchPointType.Value>
    func gap(from point: TouchPointType, to figure: RulerType) -> Res<TouchPointType.Value>
    func gap(from point: TouchPointType, to figure: CircleType) -> Res<TouchPointType.Value>
    func gap(from point: TouchPointType, to figure: ArcType) -> Res<TouchPointType.Value>
    func gap(from point: TouchPointType, to figure: CurveType) -> Res<TouchPointType.Value>
    func gap(from point: TouchPointType, to figure: QuadCurveType) -> Res<TouchPointType.Value>
}
