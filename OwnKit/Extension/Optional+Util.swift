//
//  Optional+Util.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return !isNil
    }
}