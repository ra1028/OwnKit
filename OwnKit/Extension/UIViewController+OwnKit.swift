//
//  UIViewController+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIViewController {
    @warn_unused_result
    static func instantiate() -> Self {
        return UIStoryboard.instantiate(self)
    }
    
    func addChild(viewController: UIViewController, toContainerView: UIView? = nil) {
        addChildViewController(viewController)
        let containerView: UIView = toContainerView ?? view
        containerView.addSubview(viewController.view)
        viewController.view.addFillConstraints()
    }
    
    func insertChild(viewController: UIViewController, toContainerView: UIView? = nil, atIndex: Int) {
        addChildViewController(viewController)
        let containerView: UIView = toContainerView ?? view
        containerView.insertSubview(viewController.view, atIndex: atIndex)
        viewController.view.addFillConstraints()
    }
    
    func removeFromParent() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
}