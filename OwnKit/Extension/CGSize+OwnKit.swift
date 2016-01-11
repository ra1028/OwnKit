//
//  CGSize+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/21/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension CGSize {
    init(length: CGFloat) {
        self.init(width: length, height: length)
    }
}

extension CGSize: IntegerLiteralConvertible, FloatLiteralConvertible {
    public typealias IntegerLiteralType = Int
    public typealias FloatLiteralType = Float
    
    public init(integerLiteral value: Int) {
        self.init(length: CGFloat(value))
    }
    
    public init(floatLiteral value: Float) {
        self.init(length: CGFloat(value))
    }
}
