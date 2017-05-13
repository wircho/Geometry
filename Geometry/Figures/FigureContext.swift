//
//  FigureContext.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import CoreGraphics

class FigureContext: TransmitterContext, Drawable {
    static let threadKey = "FigureContext"
    
    func drawIn(_ rect: CGRect) {
        for figure in objects {
            (figure as? Drawable)?.drawIn(rect)
        }
    }
    
    func inside(_ closure: ()->Void) {
        Association.setWeak(Thread.current, FigureContext.threadKey, self)
        closure()
        Association.setWeak(Thread.current, FigureContext.threadKey, nil)
    }
}
