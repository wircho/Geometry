//
//  AnyWeakOneDimensional.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-22.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct AnyWeakOneDimensional<P: RawPointProtocol> {
    private(set) weak var object: AnyObject?
    
    private let getOneDimensionalStorage: () -> OneDimensionalStorage<P>?
    private let getTouchingDefiningPoints: () -> [AnyFigure<P>]?
    
    let atOffset: (P.Value) -> Res<P>?
    let nearestOffsetFrom: (P) -> Res<P.Value>?
    let gapFrom: (P) -> Res<P.Value>?
    
    var oneDimensionalStorage: OneDimensionalStorage<P>? { return getOneDimensionalStorage() }
    var touchingDefiningPoints: [AnyFigure<P>]? { return getTouchingDefiningPoints() }
    
    init<F: OneDimensional>(_ figure: F) where F.P == P {
        object = figure
        getOneDimensionalStorage = { [weak figure] in return figure?.oneDimensionalStorage }
        getTouchingDefiningPoints = { [weak figure] in return figure?.touchingDefiningPoints }
        atOffset = { [weak figure] offset in return figure?.at(offset: offset) }
        nearestOffsetFrom = { [weak figure] point in return figure?.nearestOffset(from: point) }
        gapFrom = { [weak figure] point in return figure?.gap(from: point) }
    }
}
