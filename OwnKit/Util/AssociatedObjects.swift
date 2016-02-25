//
//  AssociatedObjects.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/2/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol ObjectAssociatable: class {}

extension NSObject: ObjectAssociatable {}

public extension ObjectAssociatable {
    func storeAssociate<T>(key: AssociatedKey<T>, value: T) {
        AssociatedObjects.store(self, key: key, value: value)
    }
    
    func fetchAssociate<T>(key: AssociatedKey<T>, @autoclosure initialValue: () -> T) -> T {
        return AssociatedObjects.fetch(self, key: key, initialValue: initialValue)
    }
    
    func fetchAssociate<T>(key: AssociatedKey<T>, initialValue: () -> T) -> T {
        return AssociatedObjects.fetch(self, key: key, initialValue: initialValue)
    }
    
    func clearAssociates() {
        AssociatedObjects.clear(self)
    }
}

public enum AssociationPolicy {
    case Assign
    case RetainNonatomic
    case CopyNonatomic
    case Retain
    case Copy
    
    public var value: objc_AssociationPolicy {
        switch self {
        case .Assign: return .OBJC_ASSOCIATION_ASSIGN
        case .RetainNonatomic: return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case .CopyNonatomic: return .OBJC_ASSOCIATION_COPY_NONATOMIC
        case .Retain: return .OBJC_ASSOCIATION_RETAIN
        case .Copy: return .OBJC_ASSOCIATION_COPY
        }
    }
}

public class AssociatedKeys {
    private init() {}
}

public final class AssociatedKey<T>: AssociatedKeys {
    private var keyValue: Void?
    private let policy: AssociationPolicy
    public init(_ policy: AssociationPolicy = .RetainNonatomic) {
        self.policy = policy
        super.init()
    }
}

private final class AssociatedObject<T>: NSObject, NSCopying {
    private(set) var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    dynamic func copyWithZone(zone: NSZone) -> AnyObject {
        return AssociatedObject(value)
    }    
}

public enum AssociatedObjects {    
    static func store<T>(to: AnyObject, key: AssociatedKey<T>, value: T) {
        objc_setAssociatedObject(to, &key.keyValue, AssociatedObject(value), key.policy.value)
    }
    
    static func fetch<T>(from: AnyObject, key: AssociatedKey<T>, @autoclosure initialValue: () -> T) -> T {
        if let object = objc_getAssociatedObject(from, &key.keyValue) as? AssociatedObject<T> {
            return object.value
        }
        let initialValue = initialValue()
        store(from, key: key, value: initialValue)
        return initialValue
    }
    
    static func fetch<T>(from: AnyObject, key: AssociatedKey<T>, initialValue: () -> T) -> T {
        if let object = objc_getAssociatedObject(from, &key.keyValue) as? AssociatedObject<T> {
            return object.value
        }
        let initialValue = initialValue()
        store(from, key: key, value: initialValue)
        return initialValue
    }
    
    static func clear(from: AnyObject) {
        objc_removeAssociatedObjects(from)
    }
}