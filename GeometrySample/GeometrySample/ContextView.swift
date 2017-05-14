//
//  ContextView.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

private func createFigureContext() -> FigureContext {
    let ctx = FigureContext()
    ctx.inside {
        let p0 = FreePoint(x: 20, y: 20)
        p0.color = .brown
        let p1 = FreePoint(x: 80, y: 80)
        p1.color = .blue
        let p2 = FreePoint(x: 260, y: 150)
        p2.color = .red
        let p3 = FreePoint(x: 10, y: 40)
        p3.color = .green
        let l0 = Line2Points(p0, p1)
        let s0 = Segment2Points(p1, p2)
        s0.color = .gray
        let r0 = Ray2Points(p2, p3)
        let (_, op4) = TwoRulerIntersection.create(l0, r0)
        guard let p4 = op4 else {
            fatalError("Bad 0!")
        }
        p4.radius = 8
        let c0 = CircleToPoint(p4, p1)
        let (_, oi0p0, oi0p1) = RulerCircleIntersection.create(r0, c0)
        guard let i0p0 = oi0p0, let i0p1 = oi0p1 else {
            fatalError("Bad 1!")
        }
        i0p0.color = .orange
        i0p0.radius = 5
        i0p1.color = .purple
        i0p1.radius = 5
        let l1 = Line2Points(i0p0, p1)
        l1.color = UIColor.blue.withAlphaComponent(0.5)
        l1.lineWidth = 4
        let sl0 = FreeScalar(at: 65)
        let c1 = CircleWithRadius(p2, sl0)
        c1.color = .orange
        c1.lineWidth = 3.5
        let pel0 = PerpendicularLine(p2, l0)
        pel0.color = .brown
        let pal0 = ParallelLine(p2, l0)
        pal0.color = .cyan
        let (_, op5) = TwoRulerIntersection.create(l0, pel0)
        guard let p5 = op5 else {
            fatalError("Bad 2!")
        }
        p5.color = .green
        p5.radius = 4
        let (_, oi1p0, oi1p1) = RulerCircleIntersection.create(s0, c1)
        guard let i1p0 = oi1p0, let i1p1 = oi1p1 else {
            fatalError("Bad 3!")
        }
        let c2 = CircleToPoint(i1p0, p5)
        c2.color = .red
        let (_, oi2p0, oi2p1) = RulerCircleIntersection.create(l0, c2)
        guard oi2p0 == nil, let i2p1 = oi2p1 else {
            fatalError("Bad 4!")
        }
        i2p1.color = .red
        let (_, oi3p0, oi3p1) = TwoCircleIntersection.create(c1, c2)
        guard let i3p0 = oi3p0, let i3p1 = oi3p1 else {
            fatalError("Bad 5!")
        }
        let c3 = CircleToPoint(p2, p5)
        let (_, oi4p0, oi4p1) = TwoCircleIntersection.create(c2, c3)
        guard oi4p0 == nil, let i4p1 = oi4p1 else {
            fatalError("Bad 6!")
        }
        i4p1.color = .red
        let c4 = Circumcircle(i4p1, i2p1, p2)
        c4.color = .cyan
        let (_, oi5p0, oi5p1) = TwoCircleIntersection.create(c2, c4)
        guard oi5p0 == nil && oi5p1 == nil else {
            fatalError("Bad 7!")
        }
    }
    return ctx
}

class ContextView: UIView {

    var context = createFigureContext()
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        context.drawIn(rect)
    }
}
