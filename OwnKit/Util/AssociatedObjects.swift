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
    func storeAssociate<T>(key: AssociatedKey<T>, value: T, policy: AssociationPolicy = .RetainNonatomic) {
        AssociatedObjects.store(self, key: key, value: value)
    }
    
    func fetchAssociate<T>(key: AssociatedKey<T>) -> T {
        return AssociatedObjects.fetch(self, key: key)
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
    private let initialValue: T
    public init(_ initialValue: T) {
        self.initialValue = initialValue
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
    static func store<T>(to: AnyObject, key: AssociatedKey<T>, value: T, policy: AssociationPolicy = .RetainNonatomic) {
        objc_setAssociatedObject(to, &key.keyValue, AssociatedObject(value), policy.value)
    }
    
    static func fetch<T>(from: AnyObject, key: AssociatedKey<T>) -> T {
        return (objc_getAssociatedObject(from, &key.keyValue) as? AssociatedObject<T>)?.value ?? key.initialValue
    }
    
    static func clear(from: AnyObject) {
        objc_removeAssociatedObjects(from)
    }
}