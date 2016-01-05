//
//  PopupTransitionAnimator.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol PopupTransitionable: class {
    var backgroundView: UIView { get }
    var popupView: UIView { get }
}

public final class PopupTransitionAnimator: TransitionAnimator {
    public var pushBackEnabled = true
    public var pushBackScale = 0.9.f
    
    public init(pushBackEnabled: Bool = true, pushBackScale: CGFloat = 0.95) {
        super.init()
        self.pushBackEnabled = pushBackEnabled
        self.pushBackScale = pushBackScale
    }
    
    public override func animatePresentingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {
        super.animatePresentingTransition(transitionContext, from: from, to: to)
        
        guard let popupTransitionable = to as? PopupTransitionable,
            fromView = from?.view,
            toView = to?.view,
            containerView = transitionContext.containerView() else {
                assertionFailure("Compliant the PopupTransitionable to destination view controller")
                return
        }
        
        let backgroundView = popupTransitionable.backgroundView
        let popupView = popupTransitionable.popupView
        containerView.addSubview(toView)
        popupView.layer.transform = CATransform3DMakeTranslation(0, Measure.screenHeight, 0)
        
        UIView.animate(
            duration,
            springDamping: 0.75,
            initialVelocity: 0,
            options: .CurveEaseOut,
            animations: {
                backgroundView.alpha = 0
                backgroundView.alpha = 1
                popupView.layer.transform = CATransform3DIdentity
                fromView.layer.transform = CATransform3DMakeScale(self.pushBackScale, self.pushBackScale, 1)
            }, completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
    
    public override func animateDismissingTransition(transitionContext: UIViewControllerContextTransitioning, from: UIViewController?, to: UIViewController?) {
        super.animateDismissingTransition(transitionContext, from: from, to: to)
        
        guard let popupTransitionable = from as? PopupTransitionable,
            toView = to?.view else {
            assertionFailure("Compliant the PopupTransitionable to source view controller")
            return
        }
        
        let backgroundView = popupTransitionable.backgroundView
        let popupView = popupTransitionable.popupView
        popupView.layer.transform = CATransform3DIdentity
        
        UIView.animate(
            duration,
            springDamping: 0.75,
            initialVelocity: 0,
            options: .CurveEaseIn,
            animations: {
                backgroundView.alpha = 1
                backgroundView.alpha = 0
                popupView.layer.transform = CATransform3DMakeTranslation(0, Measure.screenHeight, 0)
                toView.layer.transform = CATransform3DIdentity
            }, completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
}