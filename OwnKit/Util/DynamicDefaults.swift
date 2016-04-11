//
//  DynamicDefaults.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 3/3/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import Foundation

public class DynamicDefaults: NSObject {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    public override init() {
        super.init()
        
        registerDefaults()
        setupProperty()
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
}

extension DynamicDefaults {
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let keyPath = keyPath {
            if let value = change?["new"] where !(value is NSNull) {
                userDefaults.setObject(value is NSCoding ? NSKeyedArchiver.archivedDataWithRootObject(value) : value, forKey: storeKey(keyPath))
            }else{
                userDefaults.removeObjectForKey(storeKey(keyPath))
            }
            userDefaults.synchronize()
        }
    }
}

private extension DynamicDefaults {
    func storeKey(propertyName: String) -> String{
        return "\(self.dynamicType)_\(propertyName)"
    }
    
    func registerDefaults() {
        var dic = [String: AnyObject]()
        propertyNames.forEach {
            dic[storeKey($0)] = valueForKey($0)
        }
        userDefaults.registerDefaults(dic)
    }
    
    func setupProperty() {
        propertyNames.forEach {
            let value = userDefaults.objectForKey(storeKey($0))
            if let data = value as? NSData, decodedValue = NSKeyedUnarchiver.unarchiveObjectWithData(data){
                setValue(decodedValue, forKey: $0)
            }else{
                setValue(value, forKey: $0)
            }
        }
    }
    
    func addObserver() {
        propertyNames.forEach {
            addObserver(self, forKeyPath: $0, options: .New, context: nil)
        }
    }
    
    func removeObserver() {
        propertyNames.forEach {
            removeObserver(self, forKeyPath: $0)
        }
    }
    
    var propertyNames: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
}