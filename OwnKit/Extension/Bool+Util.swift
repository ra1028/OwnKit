//
//  Bool+Util.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension Bool {
    mutating func toggle() -> Bool {
        self = !self
        return self
    }
}