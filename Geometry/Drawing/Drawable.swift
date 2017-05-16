//
//  Drawable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

import UIKit
import Result

// MARK: - Protocol

protocol Drawable: class {
    func drawIn(_ rect: CGRect)
}

protocol SelectionDrawable: Drawable {
    func drawSelectionIn(_ rect: CGRect)
}
