//
//  UILabel+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/29/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UILabel {
    func setTextAnimated(
        text: String?,
        duration: NSTimeInterval = 0.2,
        options: UIViewAnimationOptions = .TransitionCrossDissolve) {
            guard self.text != text else { return }
            
            UIView.transitionWithView(self, duration: duration, options: options, animations: {
                if NSThread.isMainThread() {
                    self.text = text
                } else {
                    dispatch_async(dispatch_get_main_queue()) { [weak self] in
                        self?.text = text
                    }
                }
                }, completion: nil)
    }
    
    func setAttributedTextAnimated(
        text: NSAttributedString?,
        duration: NSTimeInterval = 0.2,
        options: UIViewAnimationOptions = .TransitionCrossDissolve) {
            guard self.attributedText != text else { return }
            
            UIView.transitionWithView(self, duration: duration, options: options, animations: {
                if NSThread.isMainThread() {
                    self.attributedText = text
                } else {
                    dispatch_async(dispatch_get_main_queue()) { [weak self] in
                        self?.attributedText = text
                    }
                }
                }, completion: nil)
    }
}
