//
//  TransmitterContext.swift
//  GeometrySample
//
//  Created by AdolfoX Rodriguez on 2017-05-09.
//  Copyright © 2017 Trovy. All rights reserved.
//


// TODO: Probable get rid of this

//import Foundation
//
//class TransmitterContext {
//    private(set) var objects = [Transmitter]()
//    
//    @discardableResult func append<T: Transmitter>(_ object: T) -> T {
//        objects.append(object)
//        return object
//    }
//    
//    private func removeOnly(_ object: Transmitter) -> Bool {
//        guard let index = objects.index(where: { $0 === object }) else {
//            return false
//        }
//        objects.remove(at: index)
//        return true
//    }
//    
//    func remove(_ object: Transmitter) -> Bool {
//        var set = ObjectSet<Transmitter>()
//        object.send { _ = set.insert($0) }
//        guard set.count > 0 else {
//            return false
//        }
//        for object in set {
//            _ = self.removeOnly(object)
//        }
//        return true
//    }
//}
