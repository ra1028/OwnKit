//
//  UINib+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UINib {
    static func instantiate<T: UIView>(type: T.Type, owner: AnyObject? = nil) -> T {
        let nibName = String.classNameOf(type)
        let nib = UINib(nibName: nibName, bundle: .mainBundle())
        return nib.instantiateWithOwner(owner, options: nil).first as! T
    }
    
    static func isNibExist(name: String, bundle: NSBundle = .mainBundle()) -> Bool {
        return bundle.pathForResource(name, ofType: "nib").isNotNil
    }
}