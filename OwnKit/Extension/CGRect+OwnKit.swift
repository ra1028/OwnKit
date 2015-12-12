//
//  CGRect+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/12/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension CGRect {
    init(origin: CGPoint) {
        self.init(origin: origin, size: .zero)
    }
    
    init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
    
    init(width: CGFloat = 0, height: CGFloat = 0) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
}