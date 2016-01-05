//
//  CGSize+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/21/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension CGSize {
    init(length: CGFloat) {
        self.init(width: length, height: length)
    }
}
