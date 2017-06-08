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
    var lineWidth: CGFloat = 2
}

protocol StrokeAppears: Drawable, SelectionDrawable {
    var appearance: StrokeAppearance { get set }
    func draw(in rect: CGRect, appearance: StrokeAppearance)
}

extension StrokeAppears {
    func draw(in rect: CGRect) {
        draw(in: rect, appearance: appearance)
    }
    
    func drawSelection(in rect: CGRect) {
        draw(in: rect, appearance: StrokeAppearance(color: .selection, lineWidth: appearance.lineWidth + 6))
    }
}

// MARK: - Point

struct PointAppearance {
    var color: UIColor = .black
    var radius: CGFloat = 6
}

protocol PointAppears: SelectionDrawable {
    var appearance: PointAppearance { get set }
    func draw(in rect: CGRect, appearance: PointAppearance)
}

extension PointAppears {
    func draw(in rect: CGRect) {
        draw(in: rect, appearance: appearance)
    }
    
    func drawSelection(in rect: CGRect) {
        draw(in: rect, appearance: PointAppearance(color: .selection, radius: appearance.radius + 3))
    }
}


/*
// MARK: - Appearrance

protocol Appearance {
    func prepare()
}

protocol Appears {
    associatedtype AppearanceType: Appearance
    var appearance: AppearanceType { get }
}

// MARK: - Stroke

struct StrokeAppearance<C: ColorProtocol> {
    var color: C = .black
}

protocol StrokeAppears: SelectionDrawable {
    associatedtype C: ColorProtocol
    var appearance: StrokeAppearance<C> { get set }
    func draw(in rect: CGRect, appearance: StrokeAppearance<C>)
}

extension StrokeAppears {
    func draw(in rect: CGRect) {
        draw(in: rect, appearance: appearance)
    }
    
    func drawSelection(in rect: CGRect) {
        draw(in: rect, appearance: StrokeAppearance(color: .selection, lineWidth: appearance.lineWidth + (6 as V)))
    }
}

// MARK: - Point

struct PointAppearance {
    var color: UIColor = .black
    var radius: CGFloat = 6
}

protocol PointAppears: SelectionDrawable {
    var appearance: PointAppearance { get set }
    func draw(in rect: CGRect, appearance: PointAppearance)
}

extension PointAppears {
    func draw(in rect: CGRect) {
        draw(in: rect, appearance: appearance)
    }
    
    func drawSelection(in rect: CGRect) {
        draw(in: rect, appearance: PointAppearance(color: .selection, radius: appearance.radius + 3))
    }
}

// MARK: - Fill

struct FillAppearance {
    var color: UIColor = .gray
}

protocol FillAppears: SelectionDrawable {
    var appearance: FillAppearance { get set }
    func draw(in rect: CGRect, appearance: FillAppearance)
}

extension FillAppears {
    func draw(in rect: CGRect) {
        draw(in: rect, appearance: appearance)
    }
    
    func drawSelection(in rect: CGRect) {
        draw(in: rect, appearance: FillAppearance(color: .selection))
    }
}

 */
