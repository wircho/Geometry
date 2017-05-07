//
//  Straight.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Base Class

class Straight: Figure<_Straight> {
    override func recalculate() -> _StraightResult {
        guard let conformed = self as? StraightProtocol else {
            fatalError("Use a subclass that conforms to \(StraightProtocol.self)")
        }
        return _StraightResult(kind: conformed.kind, arrow: conformed.arrow)
    }
}

// MARK: - Protocols For Every Subclass

protocol StraightProtocol {
    var kind: _Straight.Kind { get }
    var arrow: _ArrowResult { get }
}

protocol LineProtocol: StraightProtocol { }
protocol SegmentProtocol: StraightProtocol { }
protocol RayProtocol: StraightProtocol { }

extension LineProtocol { var kind: _Straight.Kind { return .line } }
extension SegmentProtocol { var kind: _Straight.Kind { return .segment } }
extension RayProtocol { var kind: _Straight.Kind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
