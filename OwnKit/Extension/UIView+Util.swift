//
//  UIView+Util.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIView {
    static func instantiate() -> Self {
        return UINib.instantiate(self)
    }
}