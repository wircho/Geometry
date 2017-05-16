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
    let p0 = FreePoint(x: 20, y: 170, in: ctx)
    p0.appearance.color = .brown
    let p1 = FreePoint(x: 80, y: 230, in: ctx)
    p1.appearance.color = .blue
    let p2 = FreePoint(x: 260, y: 300, in: ctx)
    p2.appearance.color = .red
    let p3 = FreePoint(x: 10, y: 190, in: ctx)
    p3.appearance.color = .green
    let l0 = Line2Points(p0, p1)
    let s0 = Segment2Points(p1, p2)
    s0.appearance.color = .gray
    let r0 = Ray2Points(p2, p3)
    let (_, op4) = TwoRulerIntersection.create(l0, r0)
    guard let p4 = op4 else {
        fatalError("Bad 0!")
    }
    p4.appearance.radius = 8
    let c0 = CircleToPoint(p4, p1)
    let (_, oi0p0, oi0p1) = RulerCircleIntersection.create(r0, c0)
    guard let i0p0 = oi0p0, let i0p1 = oi0p1 else {
        fatalError("Bad 1!")
    }
    i0p0.appearance.color = .orange
    i0p0.appearance.radius = 5
    i0p1.appearance.color = .purple
    i0p1.appearance.radius = 5
    let l1 = Line2Points(i0p0, p1)
    l1.appearance.color = UIColor.blue.withAlphaComponent(0.5)
    l1.appearance.lineWidth = 4
    let sl0 = FreeScalar(at: 65, in: ctx)
    let c1 = CircleWithRadius(p2, sl0)
    c1.appearance.color = .orange
    c1.appearance.lineWidth = 3.5
    let pel0 = PerpendicularLine(p2, l0)
    pel0.appearance.color = .brown
    let pal0 = ParallelLine(p2, l0)
    pal0.appearance.color = .cyan
    let (_, op5) = TwoRulerIntersection.create(l0, pel0)
    guard let p5 = op5 else {
        fatalError("Bad 2!")
    }
    p5.appearance.color = .green
    p5.appearance.radius = 4
    let (_, oi1p0, oi1p1) = RulerCircleIntersection.create(s0, c1)
    guard let i1p0 = oi1p0, let i1p1 = oi1p1 else {
        fatalError("Bad 3!")
    }
    let c2 = CircleToPoint(i1p0, p5)
    c2.appearance.color = .red
    c2.selected = true
    let (_, oi2p0, oi2p1) = RulerCircleIntersection.create(l0, c2)
    guard oi2p0 == nil, let i2p1 = oi2p1 else {
        fatalError("Bad 4!")
    }
    i2p1.appearance.color = .red
    let (_, oi3p0, oi3p1) = TwoCircleIntersection.create(c1, c2)
    guard let i3p0 = oi3p0, let i3p1 = oi3p1 else {
        fatalError("Bad 5!")
    }
    let c3 = CircleToPoint(p2, p5)
    let (_, oi4p0, oi4p1) = TwoCircleIntersection.create(c2, c3)
    guard oi4p0 == nil, let i4p1 = oi4p1 else {
        fatalError("Bad 6!")
    }
    i4p1.appearance.color = .red
    let c4 = Circumcircle(i4p1, i2p1, p2)
    c4.appearance.color = .cyan
    let (_, oi5p0, oi5p1) = TwoCircleIntersection.create(c2, c4)
    guard oi5p0 == nil && oi5p1 == nil else {
        fatalError("Bad 7!")
    }
    let arc0 = Circumarc(p0, p2, p1)
    
//    for i in 0 ... 100 {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (1 / 60.0) * Double(i)) {
//            p2.position.y -= 1
//            sl0.position -= 0.1
//        }
//    }
    return ctx
}

class ContextView: UIView, FigureContextDelegate, UIGestureRecognizerDelegate {

    var context = createFigureContext()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        context.delegate = self
        let t = UITapGestureRecognizer(target: self, action: #selector(tapped))
        t.delegate = self
        let p = UIPanGestureRecognizer(target: self, action: #selector(panned))
        p.delegate = self
        p.maximumNumberOfTouches = 1
        self.addGestureRecognizer(t)
        self.addGestureRecognizer(p)
    }
    
    func tapped(t: UITapGestureRecognizer) {
        let point = t.location(in: self)
        context.tap(point, scale: 1)
    }
    
    func panned(p: UIPanGestureRecognizer) {
        switch p.state {
        case .began:
            let point = p.location(in: self)
            context.beginPan(point, scale: 1)
        case .changed:
            let point = p.location(in: self)
            context.pan(point, scale: 1)
        default:
            context.endPan()
        }
    }
    
    func contextFiguresWillRecalculate(_: FigureContext) {
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        context.drawIn(rect)
    }
}
