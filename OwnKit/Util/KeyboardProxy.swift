//
//  KeyboardProxy.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/14/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol KeyboardObservationControllable: Discardable {
    func suspend()
    func resume()
}

public extension KeyboardObservationControllable {
    func addControllableTo(bag: KeyboardControlBag) {
        bag.addControllable(self)
    }
}

public struct KeyboardInfo {
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let animationDuration: NSTimeInterval
    public let animationCurve: UIViewAnimationOptions
    
    private init?(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return nil }
        guard let beginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue(),
        endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(),
            animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey])?.doubleValue,
            curveRawValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return nil }
        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.animationDuration = animationDuration
        self.animationCurve = UIViewAnimationOptions(rawValue: UInt(curveRawValue))
    }
}

public enum KeyboardEventType {
    case WillShow(KeyboardInfo)
    case DidShow(KeyboardInfo)
    case WillHide(KeyboardInfo)
    case DidHide(KeyboardInfo)
    case WillChangeFrame(KeyboardInfo)
    case DidChangeFrame(KeyboardInfo)
    
    private init?(notification: NSNotification) {
        guard let info = KeyboardInfo(notification: notification) else { return nil }
        
        switch notification.name {
        case UIKeyboardWillShowNotification: self = .WillShow(info)
        case UIKeyboardDidShowNotification: self = .DidShow(info)
        case UIKeyboardWillHideNotification: self = .WillHide(info)
        case UIKeyboardDidHideNotification: self = .DidHide(info)
        case UIKeyboardWillChangeFrameNotification: self = .WillChangeFrame(info)
        case UIKeyboardDidChangeFrameNotification: self = .DidChangeFrame(info)
        default: return nil
        }
    }
    
    public var notificationName: String {
        switch self {
        case .WillShow: return UIKeyboardWillShowNotification
        case .DidShow: return UIKeyboardDidShowNotification
        case .WillHide: return UIKeyboardWillHideNotification
        case .DidHide: return UIKeyboardDidHideNotification
        case .WillChangeFrame: return UIKeyboardWillChangeFrameNotification
        case .DidChangeFrame: return UIKeyboardDidChangeFrameNotification
        }
    }
    
    public static var notificationNames: [String] {
        return [
            UIKeyboardWillShowNotification,
            UIKeyboardDidShowNotification,
            UIKeyboardWillHideNotification,
            UIKeyboardDidHideNotification,
            UIKeyboardWillChangeFrameNotification,
            UIKeyboardDidChangeFrameNotification
        ]
    }
}

public final class KeyboardControlBag {
    private var controllables = [KeyboardObservationControllable]()
    private var discarded = false
    
    deinit {
        discard()
    }
    
    public init() {}
    
    public func addControllable(controllable: KeyboardObservationControllable) {
        if discarded {
            controllable.discard()
            return
        }
        controllables.append(controllable)
    }
    
    public func discard() {
        controllables.forEach { $0.discard() }
        controllables.removeAll()
        discarded = true
    }
    
    public func suspend() {
        controllables.forEach { $0.suspend() }
    }
    
    public func resume() {
        controllables.forEach { $0.resume() }
    }
}

public final class KeyboardProxy {
    private var isAppActive = true
    private var observations = [KeyboardObservationKey: KeyboardObservation]()
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public init() {
        configureObserver()
    }
}

public extension KeyboardProxy {
    func observe(on: KeyboardEventType -> Void) -> KeyboardObservationControllable {
        let key = KeyboardObservationKey()
        observations[key] = KeyboardObservation(observation: on)
        return KeyboardObservationDiscardable(proxy: self, key: key)
    }
    
    func observeWillShow(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .WillShow(let info) = $0 { on(info) }
        }
    }
    
    func observeDidShow(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .DidShow(let info) = $0 { on(info) }
        }
    }
    
    func observeWillHide(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .WillHide(let info) = $0 { on(info) }
        }
    }
    
    func observeDidHide(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .DidHide(let info) = $0 { on(info) }
        }
    }
    
    func observeWillChangeFrame(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .WillChangeFrame(let info) = $0 { on(info) }
        }
    }
    
    func observeDidChangeFrame(on: KeyboardInfo -> Void) -> KeyboardObservationControllable {
        return observe {
            if case .DidChangeFrame(let info) = $0 { on(info) }
        }
    }
    
    func removeObseavations() {
        observations.removeAll()
    }
}

private extension KeyboardProxy {
    func configureObserver() {
        KeyboardEventType.notificationNames.forEach {
            NSNotificationCenter.defaultCenter().addObserver(
                self,
                selector: #selector(KeyboardProxy.observeKeyboardEvent(_:)),
                name: $0,
                object: nil
            )
        }
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(KeyboardProxy.observeAppEvent(_:)),
            name: UIApplicationWillResignActiveNotification,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(KeyboardProxy.observeAppEvent(_:)),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil
        )
    }
    
    dynamic func observeKeyboardEvent(notification: NSNotification) {
        guard let event = KeyboardEventType(notification: notification)
            where isAppActive else { return }
        
        observations.values.forEach {
            if !$0.suspended { $0.observation(event) }
        }
    }
    
    dynamic func observeAppEvent(notification: NSNotification) {
        switch notification.name {
        case UIApplicationWillResignActiveNotification: isAppActive = false
        case UIApplicationDidBecomeActiveNotification: isAppActive = true
        default: break
        }
    }
}

private struct KeyboardObservation {
    var suspended = false
    let observation: (KeyboardEventType -> Void)
    
    init(observation: (KeyboardEventType -> Void)) {
        self.observation = observation
    }
}
    
private struct KeyboardObservationDiscardable: KeyboardObservationControllable {
    private weak var proxy: KeyboardProxy?
    private let key: KeyboardObservationKey
    
    init(proxy: KeyboardProxy, key: KeyboardObservationKey) {
        self.key = key
        self.proxy = proxy
    }
    
    func discard() {
        proxy?.observations[key] = nil
    }
    
    func suspend() {
        proxy?.observations[key]?.suspended = true
    }
    
    func resume() {
        proxy?.observations[key]?.suspended = false
    }
}

final class KeyboardObservationKey: Hashable {
    var hashValue: Int {
        return unsafeAddressOf(self).hashValue
    }
}

func ==(lhs: KeyboardObservationKey, rhs: KeyboardObservationKey) -> Bool {
    return lhs.hashValue == rhs.hashValue
}