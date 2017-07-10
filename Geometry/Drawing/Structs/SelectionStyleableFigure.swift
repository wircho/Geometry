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

final class SelectionStyleableFigure<T, S: SelectableFigureStyle>: SelectionStyleable, LayerStyleableFigure, StyleInitiableFigure {
    typealias LayerType = SelectionLayer
    typealias StyleType = S
    //associatedtype StyleType: SelectableFigureStyle
    //var selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType> { get set }
    //init(selectionStyleableFigureStorage: SelectionStyleableFigureStorage<FigureValue, StyleType>)
//}

//struct SelectionStyleableFigureStorage<FigureValue, StyleType: SelectableFigureStyle> {
    var weakFigure: AnyWeakFigure<T>
    var selected = false
    var hidden: Bool
    var style: S {
        didSet {
            selectedStyle = style.selected
            canvas?.setAppearanceDidUpdate()
        }
    }
    var selectedStyle: S
    weak var canvas: FigureCanvasBase? = nil
    
    private init<F: Figure>(figure: F, style: S = .default, hidden: Bool = false) where F.ResultValue == Res<T> {
        weakFigure = AnyWeakFigure(figure)
        self.style = style
        selectedStyle = style.selected
        self.hidden = hidden
    }
    
    convenience init<F: Figure>(_ figure: F, style: StyleType, hidden: Bool) where F.ResultValue == Res<FigureValue> {
        self.init(figure: figure, style: style, hidden: hidden)
    }
    
    convenience init<F: Figure>(_ figure: F, style: StyleType) where F.ResultValue == Res<FigureValue> {
        self.init(figure: figure, style: style, hidden: false)
    }
    
    convenience init<F: Figure>(_ figure: F, hidden: Bool) where F.ResultValue == Res<FigureValue> {
        self.init(figure: figure, style: .default, hidden: hidden)
    }
    
    convenience init<F: Figure>(_ figure: F) where F.ResultValue == Res<FigureValue> {
        self.init(figure: figure, style: .default, hidden: false)
    }
}

/*extension SelectionStyleableFigure {
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
}*/
