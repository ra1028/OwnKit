//
//  UIStoryboard+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    static func instantiateInitialViewController<T: UIViewController>(name: String, bundle: NSBundle = .mainBundle()) -> T {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateInitialViewController() as! T
    }
}