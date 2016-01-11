//
//  CGAffineTransform+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/6/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension CGAffineTransform {
    static var identity: CGAffineTransform {
        return CGAffineTransformIdentity
    }
    
    var isIdentity: Bool {
        return CGAffineTransformIsIdentity(self)
    }
    
    var invert: CGAffineTransform {
        return CGAffineTransformInvert(self)
    }
    
    static func translation(x x: CGFloat = 0, y: CGFloat = 0) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(x, y)
    }
    
    static func scale(x x: CGFloat = 1, y: CGFloat = 1) -> CGAffineTransform {
        return CGAffineTransformMakeScale(x, y)
    }
    
    static func scale(xy xy: CGFloat = 1) -> CGAffineTransform {
        return scale(x: xy, y: xy)
    }
    
    static func rotation(angle: CGFloat = 0) -> CGAffineTransform {
        return CGAffineTransformMakeRotation(angle)
    }
    
    static func string(string: String) -> CGAffineTransform {        
        return CGAffineTransformFromString(string)
    }
    
    func translation(x x: CGFloat = 0, y: CGFloat = 0) -> CGAffineTransform {
        return CGAffineTransformTranslate(self, x, y)
    }
    
    func scale(x x: CGFloat = 1, y: CGFloat = 1) -> CGAffineTransform {
        return CGAffineTransformScale(self, x, y)
    }
    
    func scale(xy xy: CGFloat = 1) -> CGAffineTransform {
        return scale(x: xy, y: xy)
    }
    
    func rotation(angle angle: CGFloat = 0) -> CGAffineTransform {
        return CGAffineTransformRotate(self, angle)
    }
    
    func concat(transform: CGAffineTransform) -> CGAffineTransform {
        return CGAffineTransformConcat(self, transform)
    }
    
    func isEqual(transform: CGAffineTransform) -> Bool {
        return CGAffineTransformEqualToTransform(self, transform)
    }
}