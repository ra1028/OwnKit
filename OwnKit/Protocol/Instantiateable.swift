//
//  Instantiateable.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol Instantiateable: class {
    static var nibFileName: String { get }
    static var nibFileBundle: NSBundle { get }
}

public extension Instantiateable where Self: UIViewController {
    static var nibFileBundle: NSBundle {
        return .mainBundle()
    }
    
    @warn_unused_result
    static func instantiate() -> Self {
        return UIStoryboard.instantiateInitialViewController(nibFileName, bundle: nibFileBundle)
    }
}

public extension Instantiateable where Self: UIView {
    static var nibFileBundle: NSBundle {
        return .mainBundle()
    }
    
    @warn_unused_result
    static func instantiate() -> Self {
        return UINib.instantiateFirstView(nibFileName, bundle: nibFileBundle)
    }
}