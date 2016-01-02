//
//  Array+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension Array {
    var isEmpty: Bool {
        return count <= 0
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func get(safeIndex: Int) -> Element? {
        if count > safeIndex && safeIndex >= 0 {
            return self[safeIndex]
        }
        return nil
    }
}