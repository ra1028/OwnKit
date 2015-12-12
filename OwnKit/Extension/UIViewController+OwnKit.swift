//
//  UIViewController+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIViewController {
    static func instantiate() -> Self {
        return UIStoryboard.instantiate(self)
    }
}