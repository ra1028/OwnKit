//
//  TransitionProxy.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/1/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit

public protocol TransitionProxyDelegate: class {
    func proxy(proxy: TransitionProxy, didPresentViewController controller: UIViewController)
    func proxy(proxy: TransitionProxy, didDismissViewController controller: UIViewController)
}

public extension TransitionProxyDelegate {
    func proxy(proxy: TransitionProxy, didPresentViewController controller: UIViewController) {}
    func proxy(proxy: TransitionProxy, didDismissViewController controller: UIViewController) {}
}

public final class TransitionProxy: NSObject {
    public weak var delegate: TransitionProxyDelegate?
    
    private var animator: TransitionAnimator?
    private weak var destination: UIViewController?
    
    public func setTransitionAnimator(animator: TransitionAnimator, destination: UIViewController) {
        self.animator = animator
        self.destination = destination
        destination.modalPresentationStyle = .OverFullScreen
        destination.transitioningDelegate = self
    }
    
    public func removeTransitionAnimator() {
        self.destination?.transitioningDelegate = nil
        self.animator = nil
        self.destination = nil
    }
}

extension TransitionProxy: UIViewControllerTransitioningDelegate {
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        delegate?.proxy(self, didPresentViewController: presented)
        return animator?.tweak { $0.type = .Present }
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        delegate?.proxy(self, didDismissViewController: dismissed)
        return animator?.tweak { $0.type = .Dismiss }
    }
}