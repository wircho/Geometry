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
        let p1 = FreePoint(x: 80, y: 80)
        let p2 = FreePoint(x: 260, y: 150)
        let p3 = FreePoint(x: 10, y: 40)
        let l0 = Line2Points(p0, p1)
        let s0 = Segment(p1, p2)
        s0.color = .gray
        let r0 = Ray(p2, p3)
        let p4 = TwoStraightIntersection(l0,r0)
        p4.radius = 8
        let c0 = CircleToPoint(p4, p1)
        let i0 = StraightCircleIntersection.create(r0, c0)
        i0.point0.color = .red
        i0.point0.radius = 5
        i0.point1.color = .green
        let l1 = Line2Points(i0.point0, p1)
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
        let p5 = TwoStraightIntersection(l0, pel0)
        p5.color = .green
        p5.radius = 4
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
