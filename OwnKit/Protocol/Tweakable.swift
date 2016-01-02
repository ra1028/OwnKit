//
//  Configurable.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/29/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public protocol Tweakable {}
public extension Tweakable {
    func tweak(body: Self -> Void) -> Self {
        body(self)
        return self
    }
}

extension NSObject: Tweakable {}