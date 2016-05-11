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
    private weak var navigationController: UINavigationController?
    private weak var navigationDelegate: UINavigationControllerDelegate?
    
    public func setTransitionAnimator(animator: TransitionAnimator, destination: UIViewController) {
        animator.didEndTransition = { [weak self, weak destination] in
            self?.removeTransitionAnimator()
            if let `self` = self, vc = destination {
                switch $0 {
                case .Present:
                    self.delegate?.proxy(self, didPresentViewController: vc)
                case .Dismiss:
                    self.delegate?.proxy(self, didDismissViewController: vc)
                }
            }
        }
        self.animator = animator
        self.destination = destination
        destination.modalPresentationStyle = .OverFullScreen
        destination.transitioningDelegate = self
    }
    
    public func setTransitionAnimator(animator: TransitionAnimator, navigationController: UINavigationController) {
        animator.didEndTransition = { [weak self, weak navigationController] in
            self?.removeTransitionAnimator()
            if let `self` = self, vc = navigationController {
                switch $0 {
                case .Present:
                    self.delegate?.proxy(self, didPresentViewController: vc)
                case .Dismiss:
                    self.delegate?.proxy(self, didDismissViewController: vc)
                }
            }
        }
        self.animator = animator
        navigationDelegate = navigationController.delegate
        self.navigationController = navigationController
        navigationController.delegate = self
    }
    
    public func removeTransitionAnimator() {
        self.destination?.transitioningDelegate = nil
        self.navigationController?.delegate = navigationDelegate
        self.destination = nil
        self.navigationController = nil
        self.animator = nil
    }
}

extension TransitionProxy: UIViewControllerTransitioningDelegate {
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {        
        return animator?.tweak { $0.type = .Present }
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator?.tweak { $0.type = .Dismiss }
    }
}

extension TransitionProxy: UINavigationControllerDelegate {
    public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .Push: return animator?.tweak { $0.type = .Present }
        case .Pop: return animator?.tweak { $0.type = .Dismiss }
        default: return nil
        }
    }
}