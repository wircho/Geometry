//
//  Drawable.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//

protocol Drawable {
    associatedtype RectType: RawRectProtocol
    func draw(in rect: RectType)
}
