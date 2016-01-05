//
//  CATransform3D+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/6/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension CATransform3D {
    typealias TranslationValue = (x: CGFloat, y: CGFloat, z: CGFloat)
    typealias ScaleValue = (x: CGFloat, y: CGFloat, z: CGFloat)
    
    static var identity: CATransform3D {
        return CATransform3DIdentity
    }
    
    var affine: CGAffineTransform {
        return CATransform3DGetAffineTransform(self)
    }
    
    var isIdentity: Bool {
        return CATransform3DIsIdentity(self)
    }
    
    var isAffine: Bool {
        return CATransform3DIsAffine(self)
    }
    
    var invert: CATransform3D {
        return CATransform3DInvert(self)
    }
    
    var translationValue: TranslationValue {
        return (m41, m42, m43)
    }
    
    var scaleValue: ScaleValue {
        return (m11, m22, m33)
    }
    
    static func translation(x x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DMakeTranslation(x, y, z)
    }
    
    static func scale(x x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DMakeScale(x, y, z)
    }
    
    static func rotation(angle angle: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DMakeRotation(angle, x, y, z)
    }
    
    static func affineTransform(affine: CGAffineTransform) -> CATransform3D {
        return CATransform3DMakeAffineTransform(affine)
    }
    
    func translation(x x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DTranslate(self, x, y, z)
    }
    
    func scale(x x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DScale(self, x, y, z)
    }
    
    func rotation(angle angle: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DRotate(self, angle, x, y, z)
    }
    
    func concat(transform: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, transform)
    }
    
    func isEqual(transform: CATransform3D) -> Bool {
        return CATransform3DEqualToTransform(self, transform)
    }
}