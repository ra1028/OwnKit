//
//  NSIndexSet+Util.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 4/27/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import Foundation

public extension NSIndexSet {
    convenience init(indexes: Int...) {
        self.init(indexes: indexes)
    }
    
    convenience init(indexes: [Int]) {
        let mutableIndexSet = NSMutableIndexSet()
        indexes.forEach(mutableIndexSet.addIndex)
        self.init(indexSet: mutableIndexSet)
    }
}