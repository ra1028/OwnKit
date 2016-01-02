//
//  UIButton+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/2/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

public extension UIButton {
    private struct AssociatedKeys {
        static var hitAreaEdgeInsetsKey: Void?
    }
    
    var hitAreaEdgeInsets: UIEdgeInsets {
        get {
            if let object = objc_getAssociatedObject(self, &AssociatedKeys.hitAreaEdgeInsetsKey) as? AssociatedObject<UIEdgeInsets> {
                return object.value
            }
            return UIEdgeInsetsZero
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hitAreaEdgeInsetsKey, AssociatedObject(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var hitTestAreaEdgeInsetTop: CGFloat {
        get { return hitAreaEdgeInsets.top }
        set { hitAreaEdgeInsets.top = newValue }
    }
    
    var hitTestAreaEdgeInsetLeft: CGFloat {
        get { return hitAreaEdgeInsets.left }
        set { hitAreaEdgeInsets.left = newValue }
    }
    
    var hitTestAreaEdgeInsetBottom: CGFloat {
        get { return hitAreaEdgeInsets.bottom }
        set { hitAreaEdgeInsets.bottom = newValue }
    }
    
    var hitTestAreaEdgeInsetRight: CGFloat {
        get { return hitAreaEdgeInsets.right }
        set { hitAreaEdgeInsets.right = newValue }
    }
    
    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let hitArea = UIEdgeInsetsInsetRect(bounds, hitAreaEdgeInsets)
        return CGRectContainsPoint(hitArea, point)
    }
}