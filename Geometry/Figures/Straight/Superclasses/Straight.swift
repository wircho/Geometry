//
//  Straight.swift
//
//  Created by AdolfoX Rodriguez on 2017-05-04.
//  Copyright © 2017 Trovy. All rights reserved.
//

import CoreGraphics
import Result

// MARK: - Straight Base Class

class Straight: Figure<Saber> {
    override func recalculate() -> SaberResult {
        guard let conformed = self as? StraightProtocol else {
            fatalError("Use a subclass that conforms to \(StraightProtocol.self)")
        }
        return SaberResult(kind: conformed.kind, arrow: conformed.arrow)
    }
}

// MARK: - Protocols For Every Subclass

protocol StraightProtocol {
    var kind: Saber.Kind { get }
    var arrow: ArrowResult { get }
}

protocol LineProtocol: StraightProtocol { }
protocol SegmentProtocol: StraightProtocol { }
protocol RayProtocol: StraightProtocol { }

extension LineProtocol { var kind: Saber.Kind { return .line } }
extension SegmentProtocol { var kind: Saber.Kind { return .segment } }
extension RayProtocol { var kind: Saber.Kind { return .ray } }

// TODO: - Parallel and Perpendicular Lines, Angle bisector, Perpendicular Bisector
