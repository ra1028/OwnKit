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
    var shouldCancelContentTouches: Bool {
        get { return fetchAssociate(.shouldCancelContentTouchesKey, initialValue: false) }
        set { storeAssociate(.shouldCancelContentTouchesKey, value: newValue) }
    }
    
    func registerCell<T: UITableViewCell>(ofClass: T.Type, subIdentifier: String? = nil) -> Self {
        let className = String.classNameOf(ofClass)
        let identifier = className + (subIdentifier ?? "")
        if UINib.isNibExist(className) {
            registerNib(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: identifier)
        } else {
            registerClass(ofClass, forCellReuseIdentifier: identifier)
        }
        return self
    }
    
    public override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return shouldCancelContentTouches ? true : super.touchesShouldCancelInContentView(view)
    }
}