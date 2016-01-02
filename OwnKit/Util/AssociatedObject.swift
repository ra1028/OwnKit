//
//  AssociatedObject.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/2/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

public final class AssociatedObject<T> {
    public private(set) var value: T
    public init(value: T) {
        self.value = value
    }
}