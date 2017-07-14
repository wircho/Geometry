//
//  AnyWeakOneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-22.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct AnyWeakOneDimensional<T, P: RawPointProtocol> {
    private let getIntersectionPoints:() -> [AnyFigure<P>]
    private let setIntersectionPoints:([AnyFigure<P>]) -> Void
    
    let anyWeakFigure: AnyWeakFigure<T>
    let atOffset: (P.Value) -> P?
    let nearestOffsetFrom: (P) -> P.Value?
    let gapFrom: (P) -> P.Value?
    var intersectionPoints: [AnyFigure<P>] {
        get { return getIntersectionPoints() }
        set { setIntersectionPoints(newValue) }
    }
    
    init<F: OneDimensional>(_ figure: F) where F.MemberPoint == P, F.FigureValue == T {
        anyWeakFigure = AnyWeakFigure(figure)
        atOffset = { [weak figure] offset in return figure?.at(offset: offset) }
        nearestOffsetFrom = { [weak figure] point in return figure?.nearestOffset(from: point) }
        gapFrom = { [weak figure] point in return figure?.gap(from: point) }
        getIntersectionPoints = { [weak figure] in return figure?.intersectionPoints ?? [] }
        setIntersectionPoints = { [weak figure] array in figure?.intersectionPoints = array }
    }
}
