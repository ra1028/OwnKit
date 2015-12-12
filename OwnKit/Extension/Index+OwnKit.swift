//
//  Index+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/11/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension String.Index {
    init(_ aInt: Int) {
        guard aInt > 0 else {
            self = "".startIndex
            return
        }
        self = (0..<aInt).map { _ in " " }.joinWithSeparator("").endIndex
    }
}