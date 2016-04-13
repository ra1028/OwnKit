//
//  UINavigationItem+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 4/14/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UINavigationItem {
    func setBackButtonTitle(title: String) {
        backBarButtonItem = UIBarButtonItem(title: title, style: .Plain, target: nil, action: nil)
    }
}