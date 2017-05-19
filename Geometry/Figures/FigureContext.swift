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
    
    let distanceError: CGFloat = 0.01
    
    func drawIn(_ rect: CGRect) {
        for figure in figures {
            (figure as? Drawable)?.drawIn(rect)
        }
        for figure in figures {
            if figure.selected {
                (figure as? SelectionDrawable)?.drawSelectionIn(rect)
            }
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
    
    private enum TouchOver {
        case this
        case other
        case both
    }
    
    private let sameError: CGFloat = 0.01
    private let oneDimensionalToPointGap: CGFloat = 18
    private let maxDistance: CGFloat = 25
    let maxSolidDistance: CGFloat = 22
    
    private func touch(this: (figure: Touchable, gap: CGFloat), over other: (figure: Touchable, gap: CGFloat)) -> TouchOver {
        switch (this.figure, other.figure) {
        case (is Point, is Point):
            if this.gap < other.gap + sameError {
                return .this
            } else if other.gap < this.gap + sameError {
                return .other
            } else {
                return .both
            }
        case (is OneDimensional, is OneDimensional):
            if this.gap < other.gap + sameError {
                return .this
            } else if other.gap < this.gap + sameError {
                return .other
            } else {
                if this.figure.touchPriority > other.figure.touchPriority {
                    return .this
                } else if other.figure.touchPriority > this.figure.touchPriority {
                    return .other
                } else {
                    return .both
                }
            }
        case (is Point, is OneDimensional):
            if this.gap < other.gap + oneDimensionalToPointGap {
                return .this
            } else {
                return .other
            }
        case (is OneDimensional, is Point):
            if other.gap < this.gap + oneDimensionalToPointGap {
                return .other
            } else {
                return .this
            }
        default:
            fatalError("Unexpected default in \(#function)")
        }
    }
    
    func touchables(near point: CGPoint, scale: CGFloat, filter:((Touchable) -> Bool)? = nil) -> [Touchable] {
        let touchables: [(figure: Touchable, gap: CGFloat)] = figures.flatMap {
            figure in
            guard let touchable = figure as? Touchable, let gap = touchable.gap(from: point).value else {
                return nil
            }
            guard filter?(touchable) ?? true else {
                return nil
            }
            return (figure: touchable, gap: gap * scale)
        }
        
        var current: [(figure: Touchable, gap: CGFloat)] = []
        
        for this in touchables {
            guard let other = current.first else {
                if this.gap < maxDistance {
                    current.append(this)
                }
                continue
            }
            switch touch(this: this, over: other) {
            case .this:
                current = [this]
            case .other: break
            case .both:
                if this.gap < other.gap {
                    current.insert(this, at: 0)
                    current = current.filter { $0.gap < this.gap + sameError }
                } else {
                    current.append(this)
                }
            }
        }
        return current.map { $0.figure }
    }
    
    func tap(_ point: CGPoint, scale: CGFloat) {
        let touchables = self.touchables(near: point, scale: scale)
        
        guard let first = touchables.first else {
            print("Bad Tap: No matches!")
            return
        }
        
        guard touchables.count == 1 else {
            print("Bad Tap: Multiple matches!")
            return
        }
        
        first.selected = !first.selected
    }
    
    var panningFigure: FreeValuedBase? = nil
    
    func beginPan(_ point: CGPoint, scale: CGFloat) {
        let touchables = self.touchables(near: point, scale: scale) { $0.selected && $0 is FreeValuedBase }
        panningFigure = touchables.first as? FreeValuedBase
    }
    
    func pan(_ point: CGPoint, scale: CGFloat) {
        guard let figure = panningFigure else {
            return
        }
        figure.placeNear(point: point)
    }
    
    func endPan() {
        panningFigure = nil
    }
    
    func setFiguresWillRecalculate() {
        delegate?.contextFiguresWillRecalculate(self)
    }
}

protocol FigureContextDelegate: class {
    func contextFiguresWillRecalculate(_: FigureContext)
}
