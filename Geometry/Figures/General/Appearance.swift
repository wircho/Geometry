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

protocol StrokeAppears: class {
    var appearance: StrokeAppearance { get set }
}

extension StrokeAppears {
    var color: UIColor {
        get { return appearance.color }
        set { appearance.color = newValue }
    }
    var lineWidth: Float {
        get { return appearance.lineWidth }
        set { appearance.lineWidth = newValue }
    }
}

// MARK: - Point

struct PointAppearance {
    var color: UIColor = .black
    var radius: Float = 6
}

protocol PointAppears: class {
    var appearance: PointAppearance { get set }
}

extension PointAppears {
    var color: UIColor {
        get { return appearance.color }
        set { appearance.color = newValue }
    }
    var radius: Float {
        get { return appearance.radius }
        set { appearance.radius = newValue }
    }
}

// MARK: - Fill

struct FillAppearance {
    var color: UIColor = .gray
}

protocol FillAppears: class {
    var appearance: FillAppearance { get set }
}

extension FillAppears {
    var color: UIColor {
        get { return appearance.color }
        set { appearance.color = newValue }
    }
}
