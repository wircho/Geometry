//
//  Straight.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

typealias StraightKind = CGStraight.Kind

// MARK: - Straight Base Class

class Straight: Figure<CGStraight> {
    override func recalculate() -> Result<CGStraight, CGError> {
        guard let conformed = self as? StraightProtocol else {
            fatalError("Use a subclass that conforms to \(StraightProtocol.self)")
        }
        return RCGStraight(kind: conformed.kind, arrow: conformed.arrow)
    }
}

// MARK: - Protocols For Every Subclass

protocol StraightProtocol {
    var kind: StraightKind { get }
    var arrow: RCGArrow { get }
}

protocol LineProtocol: StraightProtocol { }
protocol SegmentProtocol: StraightProtocol { }
protocol RayProtocol: StraightProtocol { }

extension LineProtocol { var kind: StraightKind { return .line } }
extension SegmentProtocol { var kind: StraightKind { return .segment } }
extension RayProtocol { var kind: StraightKind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
