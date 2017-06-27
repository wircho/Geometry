//
//  FigureStyleInitiable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-24.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol FigureStyleInitiable {
    associatedtype FigureValue
    associatedtype StyleType
    init<T: Figure>(_: T, style: StyleType, hidden: Bool) where T.ResultValue == Res<FigureValue>
    init<T: Figure>(_: T, style: StyleType) where T.ResultValue == Res<FigureValue>
    init<T: Figure>(_: T, hidden: Bool) where T.ResultValue == Res<FigureValue>
    init<T: Figure>(_: T) where T.ResultValue == Res<FigureValue>
}
