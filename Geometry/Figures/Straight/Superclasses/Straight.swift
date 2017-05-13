//
//  Straight.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Base Class

private let one = Result<Float, MathError>.success(1)
class Straight: Figure<Saber>, OneDimensional {
    
    var lineWidth: CGFloat = 2
    var color: UIColor = .black
    var normReciprocal: Float? = nil
    
    override func recalculate() -> SaberResult {
        guard let conformed = self as? StraightProtocol else {
            fatalError("In \(#function). Use a subclass that conforms to \(StraightProtocol.self)")
        }
        let arrow = conformed.calculateArrow()
        normReciprocal = (one / arrow.vector.norm).value
        return SaberResult(kind: conformed.kind, arrow: arrow)
    }
    
    func at(_ pos: Float) -> Spot? {
        fatalError("\(#function) must be overriden")
    }
    
    override func drawIn(_ rect: CGRect) {
        guard let saber = result.value, let exits:Two<Spot?> = intersections(saber, rect).value else { return }
        let (point0, point1) = (exits.v0 ?? saber.arrow.points.0,  exits.v1 ?? saber.arrow.points.1)
        color.setStroke()
        UIBezierPath(segment: point0, point1, lineWidth: lineWidth).stroke()
    }
}

// MARK: - Protocols For Every Subclass

protocol StraightProtocol {
    var kind: Saber.Kind { get }
    func calculateArrow() -> ArrowResult
}

protocol LineProtocol: StraightProtocol { }
protocol SegmentProtocol: StraightProtocol { }
protocol RayProtocol: StraightProtocol { }

extension LineProtocol { var kind: Saber.Kind { return .line } }
extension SegmentProtocol { var kind: Saber.Kind { return .segment } }
extension RayProtocol { var kind: Saber.Kind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
