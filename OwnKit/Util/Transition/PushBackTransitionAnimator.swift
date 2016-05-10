//
//  PushBackTransitionAnimator.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/13/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public final class PushBackTransitionAnimator: TransitionAnimator {
    public var pushBackScale = 0.95.f    
    
    private let backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.blackColor().alphaColor(0.7)
        return v
    }()
    
    public init(pushBackScale: CGFloat = 0.95) {
        super.init()
        duration = 0.6
        self.pushBackScale = pushBackScale
    }
    
    public override func animatePresentingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {
        super.animatePresentingTransition(transitionContext, from: from, to: to)
        
        guard let fromView = from?.view,
            toView = to?.view,
            containerView = transitionContext.containerView() else {
                return
        }
        
        backgroundView.frame = containerView.bounds
        containerView.addSubview(backgroundView)
        containerView.addSubview(toView)
        toView.layer.transform = .translation(x: toView.width)
        
        UIView.animate(
            duration,
            springDamping: 1,
            initialVelocity: 0,
            animations: {
                self.backgroundView.alpha = 0
                self.backgroundView.alpha = 1
                fromView.layer.transform = .scale(x: self.pushBackScale, y: self.pushBackScale)
                toView.layer.transform = .identity
            }, completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
    
    public override func animateDismissingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {
        super.animateDismissingTransition(transitionContext, from: from, to: to)
        
        guard let fromView = from?.view,
            toView = to?.view,
            containerView = transitionContext.containerView()else {
            return
        }
        
        containerView.insertSubview(toView, atIndex: 0)
        
        UIView.animate(
            duration,
            springDamping: 1,
            initialVelocity: 0,
            animations: {
                self.backgroundView.alpha = 1
                self.backgroundView.alpha = 0
                fromView.layer.transform = .translation(x: fromView.width)
                toView.layer.transform = .identity
            }, completion: { _ in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
}