//
//  Reusable.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol NibReusable {
    static var nibName: String { get }
    static var nibBundle: NSBundle { get }
}

public extension NibReusable where Self: UITableViewCell {
    static var nibBundle: NSBundle {
        return .mainBundle()
    }
}

public extension NibReusable where Self: UICollectionViewCell {
    static var nibBundle: NSBundle {
        return .mainBundle()
    }
}

public extension UITableView {
    func registerCell<T: UITableViewCell>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        registerClass(ofClass, forCellReuseIdentifier: identifier)
        return self
    }
    
    func registerCell<T: UITableViewCell where T: NibReusable>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        let nibName = T.nibName
        if UINib.isNibExist(nibName) {
            registerNib(UINib(nibName: nibName, bundle: T.nibBundle), forCellReuseIdentifier: identifier)
        } else {
            registerClass(ofClass, forCellReuseIdentifier: identifier)
        }
        return self
    }
    
    func registerView<T: UITableViewHeaderFooterView>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        registerClass(ofClass, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }
    
    func registerView<T: UITableViewHeaderFooterView where T: NibReusable>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        let nibName = T.nibName
        if UINib.isNibExist(nibName) {
            registerNib(UINib(nibName: nibName, bundle: T.nibBundle), forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            registerClass(ofClass, forHeaderFooterViewReuseIdentifier: identifier)
        }
        return self
    }
    
    func dequeueCell<T: UITableViewCell>(ofClass: T.Type = T.self, subIdentifier: String = "") -> T {
        let identifier = .classNameOf(T.self) + subIdentifier
        return dequeueReusableCellWithIdentifier(identifier) as! T
    }
    
    func dequeueCell<T: UITableViewCell>(ofClass: T.Type = T.self, subIdentifier: String = "", indexPath: NSIndexPath) -> T {
        let identifier = .classNameOf(T.self) + subIdentifier
        return dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! T
    }
    
    func dequeueView<T: UITableViewHeaderFooterView>(ofClass: T.Type = T.self, subIdentifier: String = "") -> T {
        let identifier = .classNameOf(T.self) + subIdentifier
        return dequeueReusableHeaderFooterViewWithIdentifier(identifier) as! T
    }
}

public extension UICollectionView {
    func registerCell<T: UITableViewCell>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        registerClass(ofClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    func registerCell<T: UITableViewCell where T: NibReusable>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        let nibName = T.nibName
        if UINib.isNibExist(nibName) {
            registerNib(UINib(nibName: nibName, bundle: T.nibBundle), forCellWithReuseIdentifier: identifier)
        } else {
            registerClass(ofClass, forCellWithReuseIdentifier: identifier)
        }
        return self
    }
    
    func registerHeaderView<T: UITableViewHeaderFooterView>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        return registerView(ofClass, kind: UICollectionElementKindSectionHeader, subIdentifier: subIdentifier)
    }
    
    func registerFooterView<T: UITableViewHeaderFooterView>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        return registerView(ofClass, kind: UICollectionElementKindSectionFooter, subIdentifier: subIdentifier)
    }
    
    func registerHeaderView<T: UITableViewHeaderFooterView where T: NibReusable>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        return registerView(ofClass, kind: UICollectionElementKindSectionHeader, subIdentifier: subIdentifier)
    }
    
    func registerFooterView<T: UITableViewHeaderFooterView where T: NibReusable>(ofClass: T.Type, subIdentifier: String = "") -> Self {
        return registerView(ofClass, kind: UICollectionElementKindSectionFooter, subIdentifier: subIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(ofClass: T.Type = T.self, subIdentifier: String = "", indexPath: NSIndexPath) -> T {
        let identifier = .classNameOf(T.self) + subIdentifier
        return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! T
    }
    
    func dequeueHeaderView<T: UITableViewHeaderFooterView>(ofClass: T.Type = T.self,subIdentifier: String = "", indexPath: NSIndexPath) -> T {
        return dequeueView(ofClass, kind: UICollectionElementKindSectionHeader, subIdentifier: subIdentifier, indexPath: indexPath)
    }
    
    func dequeueFooterView<T: UITableViewHeaderFooterView>(ofClass: T.Type = T.self,subIdentifier: String = "", indexPath: NSIndexPath) -> T {
        return dequeueView(ofClass, kind: UICollectionElementKindSectionFooter, subIdentifier: subIdentifier, indexPath: indexPath)
    }
}

private extension UICollectionView {
    func registerView<T: UITableViewHeaderFooterView>(ofClass: T.Type, kind: String, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        registerClass(ofClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }
    
    func registerView<T: UITableViewHeaderFooterView where T: NibReusable>(ofClass: T.Type, kind: String, subIdentifier: String = "") -> Self {
        let identifier = .classNameOf(T.self) + subIdentifier
        let nibName = T.nibName
        if UINib.isNibExist(nibName) {
            registerNib(UINib(nibName: nibName, bundle: T.nibBundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            registerClass(ofClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
        return self
    }
    
    func dequeueView<T: UITableViewHeaderFooterView>(ofClass: T.Type = T.self, kind: String, subIdentifier: String = "", indexPath: NSIndexPath) -> T {
        let identifier = .classNameOf(T.self) + subIdentifier        
        return dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: identifier, forIndexPath: indexPath) as! T
    }
}