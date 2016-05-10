//
//  UITableView+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/8/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

private extension AssociatedKeys {
    static var shouldCancelContentTouchesKey = AssociatedKey<Bool>()
}

public extension UITableView {
    public var shouldCancelContentTouches: Bool {
        get {
            return AssociatedObjects.fetch(self, key: .shouldCancelContentTouchesKey, initialValue: false)
        }
        set {
            AssociatedObjects.store(self, key: .shouldCancelContentTouchesKey, value: newValue)
        }
    }
    
    public override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return shouldCancelContentTouches ? true : super.touchesShouldCancelInContentView(view)
    }
    
    public func deselectSelectedRow() {
        guard let indexPath = indexPathForSelectedRow else { return }
        deselectRowAtIndexPath(indexPath, animated: true)
    }
}