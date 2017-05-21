//
//  ContextView.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

// Lots of things
private func createFigureContext0() -> FigureContext {
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

// Arc with sliding point
private func createFigureContext1() -> FigureContext {
    let ctx = FigureContext()
    let p0 = FreePoint(x: 50, y: 50, in: ctx)
    let p1 = FreePoint(x: 70, y: 250, in: ctx)
    let p2 = FreePoint(x: 250, y: 280, in: ctx)
    let arc = Circumarc(p0, p1, p2)
    let arcPoint = SlidingPoint(arc, at: 0.5)
    arcPoint.appearance.color = .red
    return ctx
}

// Curve with sliding point
private func createFigureContext2() -> FigureContext {
    let ctx = FigureContext()
    let p0 = FreePoint(x: 50, y: 50, in: ctx)
    let p1 = FreePoint(x: 70, y: 100, in: ctx)
    let p2 = FreePoint(x: 150, y: 150, in: ctx)
    let p3 = FreePoint(x: 200, y: 100, in: ctx)
    let curve = Curve4Points(p0, p1, p2, p3)
    let curvePoint = SlidingPoint(curve, at: 0.5)
    curvePoint.appearance.color = .red
    //let arc = Circumarc(p0, p1, p2)
    //let arcPoint = SlidingPoint(arc, at: 0.5)
    //arcPoint.appearance.color = .red
    return ctx
}

// Curve with sliding point
private func createFigureContext3() -> FigureContext {
    let ctx = FigureContext()
    let p0 = FreePoint(x: 50, y: 50, in: ctx)
    let p1 = FreePoint(x: 70, y: 100, in: ctx)
    let p2 = FreePoint(x: 200, y: 100, in: ctx)
    let curve = QuadCurve3Points(p0, p1, p2)
    let curvePoint = SlidingPoint(curve, at: 0.5)
    curvePoint.appearance.color = .red
    //let arc = Circumarc(p0, p1, p2)
    //let arcPoint = SlidingPoint(arc, at: 0.5)
    //arcPoint.appearance.color = .red
    return ctx
}

// Playful circles/arcs
private func createFigureContext4() -> FigureContext {
    let clear = UIColor.clear
    let ctx = FigureContext()
    let radius0 = FreeScalar(at: 100, in: ctx)
    let radius1 = FreeScalar(at: 200, in: ctx)
    let center0 = FreePoint(x: 110, y: 250, in: ctx)
    let center1 = FreePoint(x: 205, y: 250, in: ctx)
    let circle0 = CircleWithRadius(center0, radius0)
    let circle1 = CircleWithRadius(center1, radius1)
    center0.selected = true
    center0.appearance.color = .red
    center1.appearance.color = clear
    circle0.appearance.color = clear
    circle1.appearance.color = clear
    let (_, _a, _b) = TwoCircleIntersection.create(circle0, circle1)
    guard let a = _a, let b = _b else {
        fatalError("No intersection points!")
    }
    a.appearance.color = clear
    b.appearance.color = clear
    let l = Line2Points(center0, center1)
    l.appearance.color = clear
    let (_, _x0, _y0) = RulerCircleIntersection.create(l, circle0)
    let (_, y1, _x1) = RulerCircleIntersection.create(l, circle1)
    y1?.appearance.color = clear
    guard let x0 = _x0, let x1 = _x1, let y0 = _y0 else {
        fatalError("No intersection points!")
    }
    x0.appearance.color = clear
    x1.appearance.color = clear
    y0.appearance.color = clear
    let arc0 = Circumarc(a,x0,b)
    let arc1 = Circumarc(a,x1,b)
    arc0.appearance.color = .red
    arc1.appearance.color = .red
    let circle1Copy = CircleWithRadius(x0,radius1)
    circle1Copy.appearance.color = clear
    let (_, _c, _d) = RulerCircleIntersection.create(l, circle1Copy)
    _d?.appearance.color = clear
    guard let c = _c else {
        fatalError("No intersection points!")
    }
    c.appearance.color = clear
    let inRay = Ray2Points(x0, c)
    inRay.appearance.color = clear
    let (_, _e, _f) = RulerCircleIntersection.create(inRay, circle1)
    _e?.appearance.color = clear
    guard let f = _f else {
        fatalError("No intersection points!")
    }
    f.appearance.color = clear
    let redCircle1 = CircleToPoint(center1, f)
    redCircle1.appearance.color = .red
    let outRay = Ray2Points(y0, center1)
    outRay.appearance.color = clear
    let (_, _g, h) = RulerCircleIntersection.create(outRay, circle1)
    h?.appearance.color = clear
    guard let g = _g else {
        fatalError("No intersection points!")
    }
    g.appearance.color = clear
    let redCircle1Out = CircleToPoint(center1, g)
    redCircle1Out.appearance.color = .red
    let outRay0 = Ray2Points(center0, g)
    outRay0.appearance.color = clear
    let (_, i, _j) = RulerCircleIntersection.create(outRay0, circle0)
    guard let j = _j else {
        fatalError("No intersection points!")
    }
    j.appearance.color = clear
    let redCircle0 = CircleToPoint(center0, j)
    redCircle0.appearance.color = .red
    return ctx
}

class ContextView: UIView, FigureContextDelegate, UIGestureRecognizerDelegate {

    var context = createFigureContext4()
    
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
        context.draw(in: rect)
    }
}
