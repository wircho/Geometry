//
//  FigureContext.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import Foundation
import CoreGraphics

class FigureContext: Drawable {
    var figures: [FigureBase] = []
    weak var delegate: FigureContextDelegate? = nil
    
    func drawIn(_ rect: CGRect) {
        for figure in figures {
            if figure.selected {
                (figure as? SelectionDrawable)?.drawSelectionIn(rect)
            }
        }
        for figure in figures {
            (figure as? Drawable)?.drawIn(rect)
        }
    }
    
    @discardableResult func append<T: FigureBase>(_ figure: T) -> T {
        figures.append(figure)
        figure.context = self
        return figure
    }
    
    private func removeOnly(_ figure: FigureBase) {
        guard let index = figures.index(where: { $0 === figure }) else {
            return
        }
        figures.remove(at: index)
    }
    
    func remove(_ object: FigureBase) -> Bool {
        var set = ObjectSet<AnyObject>()
        object.send { _ = set.insert($0) }
        guard set.count > 0 else {
            return false
        }
        for object in set {
            guard let figure = object as? FigureBase else { continue }
            removeOnly(figure)
        }
        return true
    }
    
    func setFiguresWillRecalculate() {
        delegate?.contextFiguresWillRecalculate(self)
    }
}

protocol FigureContextDelegate: class {
    func contextFiguresWillRecalculate(_: FigureContext)
}
