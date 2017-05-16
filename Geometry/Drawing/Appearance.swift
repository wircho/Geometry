//
//  Appearance.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-13.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit

// MARK: - Stroke

struct StrokeAppearance {
    var color: UIColor = .black
    var lineWidth: Float = 2
}

protocol StrokeAppears: SelectionDrawable {
    var appearance: StrokeAppearance { get set }
    func drawIn(_ rect: CGRect, appearance: StrokeAppearance)
}

extension StrokeAppears {
    func drawIn(_ rect: CGRect) {
        drawIn(rect, appearance: appearance)
    }
    
    func drawSelectionIn(_ rect: CGRect) {
        drawIn(rect, appearance: StrokeAppearance(color: .selection, lineWidth: appearance.lineWidth + 6))
    }
}

// MARK: - Point

struct PointAppearance {
    var color: UIColor = .black
    var radius: Float = 6
}

protocol PointAppears: SelectionDrawable {
    var appearance: PointAppearance { get set }
    func drawIn(_ rect: CGRect, appearance: PointAppearance)
}

extension PointAppears {
    func drawIn(_ rect: CGRect) {
        drawIn(rect, appearance: appearance)
    }
    
    func drawSelectionIn(_ rect: CGRect) {
        drawIn(rect, appearance: PointAppearance(color: .selection, radius: appearance.radius + 3))
    }
}

// MARK: - Fill

struct FillAppearance {
    var color: UIColor = .gray
}

protocol FillAppears: SelectionDrawable {
    var appearance: FillAppearance { get set }
    func drawIn(_ rect: CGRect, appearance: FillAppearance)
}

extension FillAppears {
    func drawIn(_ rect: CGRect) {
        drawIn(rect, appearance: appearance)
    }
    
    func drawSelectionIn(_ rect: CGRect) {
        drawIn(rect, appearance: FillAppearance(color: .selection))
    }
}
