//
//  AnimationChain.swift
//  OwnKit
//
//  Created by 青山 遼 on 2016/04/18.
//  Copyright © 2016年 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct AnimationChain {
    private let queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)
    private let semaphore = dispatch_semaphore_create(0)
    private var cancelled = false
    
    private init() {}
}

public extension AnimationChain {
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) -> AnimationChain {
        let chain = AnimationChain()
        chain.animate(duration, delay: delay, options: options, animations: animations)
        return chain
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) -> AnimationChain {
        let chain = AnimationChain()
        chain.animate(duration, delay: delay, options: options, animations: animations, completion: completion)
        return chain
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) -> AnimationChain {
        let chain = AnimationChain()
        chain.animate(duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animations: animations)
        return chain
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) -> AnimationChain {
        let chain = AnimationChain()
        chain.animate(duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animations: animations, completion: completion)
        return chain
    }
    
    func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) {
        performAndWait {
            UIView.animate(duration, delay: delay, options: options, animations: animations) { _ in self.resume() }
        }
    }
    
    func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) {
        performAndWait {
            UIView.animate(duration, delay: delay, options: options, animations: animations) {
                completion?($0)
                self.resume()
            }
        }
    }
    
    func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) {
        performAndWait {
            UIView.animate(duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animations: animations) { _ in
                self.resume()
            }
        }
    }
    
    func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) {
        performAndWait {
            UIView.animate(duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animations: animations) {
                completion?($0)
                self.resume()
            }
        }
    }
    
    mutating func cancel() {
        cancelled = true
    }
}

private extension AnimationChain {
    func performAndWait(perform: () -> Void) {
        dispatch_async(queue) {
            if self.cancelled { return }
            
            dispatch_async(dispatch_get_main_queue(), perform)
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
        }
    }
    
    private func resume() {
        dispatch_semaphore_signal(semaphore)
    }
}