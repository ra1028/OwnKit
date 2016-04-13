//
//  UIViewController+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIViewController {    
    func addChild(viewController: UIViewController, toContainerView: UIView? = nil) {
        addChildViewController(viewController)
        let containerView: UIView = toContainerView ?? view
        containerView.addSubview(viewController.view)
        viewController.view.addFillConstraints()
    }
    
    func insertChild(viewController: UIViewController, toContainerView: UIView? = nil, atIndex: Int = 0) {
        addChildViewController(viewController)
        let containerView = toContainerView ?? view!
        containerView.insertSubview(viewController.view, atIndex: atIndex)
        viewController.view.addFillConstraints()
    }
    
    func removeFromParent() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}