//
//  UIBarButtonItem+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 4/14/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    public convenience init(
        title: String,
        font: UIFont,
        color: UIColor,
        style: UIBarButtonItemStyle = .Plain,
        target: AnyObject? = nil,
        action: Selector = nil) {
        self.init(title: title, style: style, target: target, action: action)
        let attributes = Attribute(.Font(font)).add(.Color(color))
        setTitleTextAttributes(attributes.attributes, forState: .Normal)
    }
}