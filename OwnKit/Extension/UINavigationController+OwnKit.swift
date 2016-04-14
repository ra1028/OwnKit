//
//  UINavigationController.swift
//  OwnKit
//
//  Created by 青山 遼 on 2016/04/14.
//  Copyright © 2016年 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func push(viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
}