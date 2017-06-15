//
//  Drawable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

//import UIKit
//import Result


// MARK: - Protocol

protocol Drawable {
    associatedtype RectType: RawRectProtocol
    func draw(in rect: RectType)
}

//struct AnyDrawable<R: RawRectProtocol> {
//    private var _draw: (R) -> Void
//    
//    init<D: Drawable>(_ drawable: D) where D.RectType == R {
//        _draw = { drawable.draw(in: $0) }
//    }
//    
//    func draw(in rect: R) {
//        _draw(rect)
//    }
//}
