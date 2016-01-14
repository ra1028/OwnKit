//
//  TransitionAnimator.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public enum TransitionType {
        case Present
        case Dismiss
    }
    
    var willEndTransion: (() -> Void)?
    
    public var duration: NSTimeInterval = 0.5
    public var type: TransitionType = .Present    
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        switch type {
        case .Present:
            animatePresentingTransition(transitionContext, from: fromViewController, to: toViewController)
        case .Dismiss:
            willEndTransion?()
            animateDismissingTransition(transitionContext, from: fromViewController, to: toViewController)
        }
    }
    
    public func animatePresentingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {}
    
    public func animateDismissingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {}    
}