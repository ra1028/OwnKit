//
//  UIButton+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/2/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

private extension AssociatedKeys {
    static var hitAreaEdgeInsetsKey = AssociatedKey(UIEdgeInsetsZero)
}

public extension UIButton {
    var hitAreaEdgeInsets: UIEdgeInsets {
        get { return fetchAssociate(.hitAreaEdgeInsetsKey) }
        set { storeAssociate(.hitAreaEdgeInsetsKey, value: newValue) }
    }
    
    func setHitAreaEdgeInsets(top: CGFloat = 0, right: CGFloat = 0 , bottom: CGFloat = 0, left: CGFloat = 0) {
        hitAreaEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func setHitAreaEdgeInsets(inset inset: CGFloat) {
        hitAreaEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let hitArea = UIEdgeInsetsInsetRect(bounds, hitAreaEdgeInsets)
        return CGRectContainsPoint(hitArea, point)
    }
}