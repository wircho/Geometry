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

protocol SelectionStyleableFigure: SelectionStyleable, LayerStyleableFigure, StyleInitiableFigure {
    associatedtype StyleType: SelectableFigureStyle
    var selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType> { get set }
    init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>)
}

struct SelectionStyleableFigureStorage<FigureValue, StyleType: SelectableFigureStyle> {
    var weakFigure: AnyWeakFigure<FigureValue>
    var selected = false
    var hidden: Bool
    var style: StyleType {
        didSet {
            selectedStyle = style.selected
            canvas?.setAppearanceDidUpdate()
        }
    }
    var selectedStyle: StyleType
    weak var canvas: FigureCanvasBase? = nil
    
    init<F: Figure>(_ figure: F, style: StyleType = .default, hidden: Bool = false) where F.ResultValue == Res<FigureValue> {
        weakFigure = AnyWeakFigure(figure)
        self.style = style
        selectedStyle = style.selected
        self.hidden = hidden
    }
}

extension SelectionStyleableFigure {
    init<F: Figure>(_ figure: F, style: StyleType, hidden: Bool) where F.ResultValue == Res<FigureValue> {
        self.init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage(figure, style: style, hidden: hidden))
    }
    
    init<F: Figure>(_ figure: F, style: StyleType) where F.ResultValue == Res<FigureValue> {
        self.init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage(figure, style: style))
    }
    
    init<F: Figure>(_ figure: F, hidden: Bool) where F.ResultValue == Res<FigureValue> {
        self.init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage(figure, hidden: hidden))
    }
    
    init<F: Figure>(_ figure: F) where F.ResultValue == Res<FigureValue> {
        self.init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage(figure))
    }
    
    var selected: Bool {
        get { return selectionStyleableFigureStorage.selected }
        set { selectionStyleableFigureStorage.selected = newValue }
    }
    
    var hidden: Bool {
        get { return selectionStyleableFigureStorage.hidden }
        set { selectionStyleableFigureStorage.hidden = newValue }
    }
    
    var style: StyleType {
        get { return selectionStyleableFigureStorage.style }
        set { selectionStyleableFigureStorage.style = newValue }
    }
    
    var selectedStyle: StyleType {
        get { return selectionStyleableFigureStorage.selectedStyle }
    }
    
    var weakFigure: AnyWeakFigure<FigureValue> {
        get { return selectionStyleableFigureStorage.weakFigure }
        set { selectionStyleableFigureStorage.weakFigure = newValue }
    }
    
    var canvas: FigureCanvasBase? {
        get { return selectionStyleableFigureStorage.canvas }
        set { selectionStyleableFigureStorage.canvas = newValue }
    }
}
