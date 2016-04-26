//
//  UINavigationController.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2016/04/14.
//  Copyright © 2016年 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func push(viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        popViewControllerAnimated(animated)        
    }
}