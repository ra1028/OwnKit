//
//  UITableView+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/8/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

private extension AssociatedKeys {
    static var shouldCancelContentTouchesKey = AssociatedKey(false)
}

public extension UITableView {
    var shouldCancelContentTouches: Bool {
        get { return fetchAssociate(.shouldCancelContentTouchesKey) }
        set { storeAssociate(.shouldCancelContentTouchesKey, value: newValue) }
    }
    
    public override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return shouldCancelContentTouches ? true : super.touchesShouldCancelInContentView(view)
    }
}