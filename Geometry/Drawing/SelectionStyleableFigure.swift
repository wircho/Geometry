//
//  SelectionStyleableFigure.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-06-20.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol SelectableFigureStyle: FigureStyle {
    var selected: Self { get }
}

protocol SelectionStyleableFigure: SelectionStyleable, LayerStyleableFigure, FigureStyleInitiable {
    associatedtype StyleType: SelectableFigureStyle
    var storage: SelectionStyleableFigureStorage<FigureValue, StyleType> { get set }
    init(storage: SelectionStyleableFigureStorage<FigureValue, StyleType>)
}

struct SelectionStyleableFigureStorage<FigureValue, StyleType: SelectableFigureStyle> {
    var weakFigure: AnyWeakFigure<FigureValue>
    var selected = false
    var hidden = false
    var normalStyle: StyleType { didSet { selectedStyle = normalStyle.selected } }
    var selectedStyle: StyleType
    
    init<F: Figure>(_ figure: F, style: StyleType) where F.ResultValue == Res<FigureValue> {
        weakFigure = AnyWeakFigure(figure)
        normalStyle = style
        selectedStyle = style.selected
    }
    
    init<F: Figure>(_ figure: F) where F.ResultValue == Res<FigureValue> {
        self.init(figure, style: .default)
    }
}

extension SelectionStyleableFigure {
    init<F: Figure>(_ figure: F, style: StyleType) where F.ResultValue == Res<FigureValue> {
        self.init(storage: SelectionStyleableFigureStorage(figure, style: style))
    }
    
    init<F: Figure>(_ figure: F) where F.ResultValue == Res<FigureValue> {
        self.init(storage: SelectionStyleableFigureStorage(figure))
    }
    
    var selected: Bool {
        get { return storage.selected }
        set { storage.selected = newValue }
    }
    
    var hidden: Bool {
        get { return storage.hidden }
        set { storage.hidden = newValue }
    }
    
    var normalStyle: StyleType {
        get { return storage.normalStyle }
        set { storage.normalStyle = newValue }
    }
    
    var selectedStyle: StyleType {
        get { return storage.selectedStyle }
    }
    
    var weakFigure: AnyWeakFigure<FigureValue> {
        get { return storage.weakFigure }
        set { storage.weakFigure = newValue }
    }
}
