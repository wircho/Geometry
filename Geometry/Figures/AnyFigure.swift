//
//  AnyFigure.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-22.
//  Copyright © 2017 Trovy. All rights reserved.
//

struct AnyFigure<T> {
    let figure: FigureBase
    private let getResult: () -> Res<T>
    var result: Res<T> { return getResult() }
    private let getAnyWeakFigure: () -> AnyWeakFigure<T>
    var anyWeakFigure: AnyWeakFigure<T> { return getAnyWeakFigure() }
    
    init<F: Figure>(_ figure: F) where F.ResultValue == Res<T> {
        self.figure = figure
        getResult = { figure.result }
        getAnyWeakFigure = { AnyWeakFigure(figure) }
    }
}

struct AnyWeakFigure<T> {
    private(set) weak var figure: FigureBase?
    private let getResult: () -> Res<T>?
    var result: Res<T>? { return getResult() }
    private let getAnyFigure: () -> AnyFigure<T>?
    var anyFigure: AnyFigure<T>? { return getAnyFigure() }
    
    init<F: Figure>(_ figure: F) where F.ResultValue == Res<T> {
        self.figure = figure
        getResult = { [weak figure] in figure?.result }
        getAnyFigure = {
            [weak figure] in
            guard let figure = figure else { return nil }
            return AnyFigure(figure)
        }
    }
    
    init() {
        figure = nil
        getResult = { nil }
        getAnyFigure = { nil }
    }
}
