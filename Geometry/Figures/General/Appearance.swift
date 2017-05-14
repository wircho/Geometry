//
//  Appearance.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

struct Appearance {
    var color: UIColor = .black
    var lineWidth: Float = 2
    
    init() { }
    init(radius: Float) {
        self.lineWidth = radius * 2
    }
    
    init(radiusMultiplier: Float) {
        self.lineWidth = self.lineWidth * radiusMultiplier
    }
}

protocol Appears: class {
    var appearance: Appearance { get set }
}

extension Appears {
    var color: UIColor {
        get { return appearance.color }
        set { appearance.color = newValue }
    }
    var lineWidth: Float {
        get { return appearance.lineWidth }
        set { appearance.lineWidth = newValue }
    }
}

//struct AppearingFigureStorage<Value> {
//    var appearance = Appearance()
//    var storage = FigureStorage<Value>()
//}
//
//protocol AppearingFigure: Figure, Appears {
//    var appearingStorage: AppearingFigureStorage<Self.Value> { get set }
//}
//
//extension AppearingFigure {
//    var appearance: Appearance {
//        get { return appearingStorage.appearance }
//        set { appearingStorage.appearance = newValue }
//    }
//    var storage: FigureStorage<Self.Value> {
//        get { return appearingStorage.storage }
//        set { appearingStorage.storage = newValue }
//    }
//}
