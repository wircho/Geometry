//
//  CoreExtensions.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-10.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

extension CGFloat: RawValueProtocol {
    func sine() -> CGFloat { return sin(self) }
    func cosine() -> CGFloat { return cos(self) }
    func arctangent2(_ x: CGFloat) -> CGFloat { return atan2(self, x) }
    func cubeRoot() -> CGFloat {
        if self >= 0 {
            return pow(self, 1/3)
        } else {
            return -pow(-self, 1/3)
        }
    }
}

extension CGPoint: RawPointProtocol { }
 
extension CGRect: RawRectProtocol { }


extension UIBezierPath {
    convenience init(circle: RawCircle<CGPoint>, lineWidth: CGFloat = 1) {
        let rect = CGRect(circle: circle)
        self.init(ovalIn: rect)
        self.lineWidth = lineWidth
    }
    
    convenience init(segment point0: CGPoint, _ point1: CGPoint, lineWidth: CGFloat = 1) {
        self.init()
        self.move(to: point0)
        self.addLine(to: point1)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
    
    convenience init(arc: RawArc<CGPoint>, lineWidth: CGFloat = 1) {
        self.init()
        let angleValues = arc.angleValues
        self.addArc(withCenter: arc.circle.center, radius: arc.circle.radius, startAngle: angleValues.v0, endAngle: angleValues.v1, clockwise: true)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
    
    convenience init(curve: RawCurve<CGPoint>, lineWidth: CGFloat = 1) {
        self.init()
        self.move(to: curve.point0)
        self.addCurve(to: curve.point1, controlPoint1: curve.control0, controlPoint2: curve.control1)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }
    
    convenience init(quadCurve: RawQuadCurve<CGPoint>, lineWidth: CGFloat = 1) {
        self.init()
        self.move(to: quadCurve.point0)
        self.addQuadCurve(to: quadCurve.point1, controlPoint: quadCurve.control)
        self.lineWidth = lineWidth
        self.lineCapStyle = .round
    }

}

private var _selectionImage: UIImage? = nil
extension UIImage {
    static var selection: UIImage {
        if let sel = _selectionImage {
            return sel
        } else {
            let squareWidth: CGFloat = 2
            let imageWidth = 2 * squareWidth
            let imageSize = CGSize(width: imageWidth, height: imageWidth)
            UIGraphicsBeginImageContextWithOptions(imageSize, false, 1)
            UIColor.black.withAlphaComponent(0.5).setFill()
            UIRectFill(CGRect(x: 0, y: 0, width: squareWidth, height: squareWidth))
            UIColor.white.withAlphaComponent(0.5).setFill()
            UIRectFill(CGRect(x: squareWidth, y: squareWidth, width: squareWidth, height: squareWidth))
            let sel = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            _selectionImage = sel
            return sel
        }
    }
}

extension UIColor: FigureColor { }

private var _selectionColor: UIColor? = nil
extension UIColor {
    static var selection: UIColor {
        if let sel = _selectionColor {
            return sel
        } else {
            let sel = UIColor(patternImage: .selection)
            _selectionColor = sel
            return sel
        }
    }
}
