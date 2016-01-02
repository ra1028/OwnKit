//
//  Optional+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public protocol OptionalType {
    typealias T
    var optionalValue: T? { get }
}

extension Optional: OptionalType {
    public var optionalValue: Wrapped? {
        return self
    }
}

public extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return !isNil
    }
    
    func unwrap(@noescape f: Wrapped -> Void) {
        _ = map { f($0) }
    }
}

public extension Optional where Wrapped: BooleanType {
    func someIf(@noescape f: () -> Void) -> Bool? {
        if let some = self where some { f() }
        return self?.boolValue
    }
    
    func someElse(@noescape f: () -> Void) -> Bool? {
        if let some = self where !some { f() }
        return self?.boolValue
    }
}