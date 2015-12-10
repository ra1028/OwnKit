//
//  Int+Util.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var isOdd: Bool {
        return !isEven
    }
    
    func times(@noescape body: Int -> ()) {
        guard self > 0 else { return }
        (0..<self).forEach(body)
    }
    
    func upTo(max: Int, @noescape body: Int -> ()) {
        guard self <= max else { return }
        (self...max).forEach(body)
    }
    
    func downTo(min: Int, @noescape body: Int -> ()) {
        guard self >= min else { return }
        (min...self).reverse().forEach(body)
    }
    
    func toIndex() -> String.Index {
        return String.Index(self)
    }
}
