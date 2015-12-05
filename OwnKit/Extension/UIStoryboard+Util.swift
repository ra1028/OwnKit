//
//  UIStoryboard+Util.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    static func instantiate<T: UIViewController>(type: T.Type) -> T {
        let className = classNameOf(type)
        let storyboardName = className.stringByReplacingOccurrencesOfString("ViewController", withString: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: .mainBundle())
        return storyboard.instantiateInitialViewController() as! T
    }
}