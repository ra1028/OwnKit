//
//  Util.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/5/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import Foundation

public func classNameOf(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
}