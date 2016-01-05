//
//  UIView+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIView {
    var size: CGSize {
        return bounds.size
    }
    
    var origin: CGPoint {
        return frame.origin
    }
    
    var width: CGFloat {
        return size.width
    }
    
    var height: CGFloat {
        return size.height
    }
    
    var x: CGFloat {
        return origin.x
    }
    
    var y: CGFloat {
        return origin.y
    }
    
    var minX: CGFloat {
        return frame.minX
    }
    
    var minY: CGFloat {
        return frame.minY
    }
    
    var midX: CGFloat {
        return frame.midX
    }
    
    var midY: CGFloat {
        return frame.midY
    }
    
    var maxX: CGFloat {
        return frame.maxX
    }
    
    var maxY: CGFloat {
        return frame.maxY
    }
    
    @warn_unused_result
    static func instantiate() -> Self {
        return UINib.instantiate(self)
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) {
            animate(duration, delay: delay, options: options, animations: animations, completion: nil)
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) {
            animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: completion)
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void) {
            animate(duration, delay: delay, springDamping: springDamping, initialVelocity: initialVelocity, options: options, animations: animations, completion: nil)
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)?) {
            animateWithDuration(duration, delay: delay, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: options, animations: animations, completion: completion)
    }
    
    func setHiddenAnimated(hidden: Bool, duration: NSTimeInterval = 0.2) {
        guard self.hidden != hidden else { return }
        
        UIView.transitionWithView(
            self,
            duration: duration,
            options: .TransitionCrossDissolve,
            animations: {
                if NSThread.isMainThread() {
                    self.hidden = hidden
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.hidden = hidden
                    }
                }
            },
            completion: nil
        )
    }
    
    func addFillConstraints() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints =
        NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[view]-0-|",
            options: [],
            metrics: nil,
            views: ["view": self]
            ) +
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-0-[view]-0-|",
                options: [],
                metrics: nil,
                views: ["view": self]
        )
        superview.addConstraints(constraints)
    }
    
    func applyShadow(
        color: UIColor = .blackColor(),
        opacity: Float = 1,
        radius: CGFloat = 3,
        offset: CGSize = .zero,
        rasterize: Bool = false
        ) {
            layer.masksToBounds = false
            layer.shadowColor = color.CGColor
            layer.shadowOpacity = opacity
            layer.shadowRadius = radius
            layer.shadowOffset = offset
            if rasterize {
                layer.shouldRasterize = true
                layer.shadowPath = UIBezierPath(rect: bounds).CGPath
                layer.rasterizationScale = Measure.screenScale
            }
    }
    
    func applyEdgeLine(color: UIColor, width: CGFloat = 1, edges: UIRectEdge) {
        func addLineWithVisualFormatOfConstraints(horizontal h: String, vertical v: String) {
            let line = UIView()
            line.backgroundColor = color
            line.translatesAutoresizingMaskIntoConstraints = false
            addSubview(line)
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(
                h,
                options: [],
                metrics: ["width": width],
                views: ["line": line]
                ) +
                NSLayoutConstraint.constraintsWithVisualFormat(
                    v,
                    options: [],
                    metrics: ["width": width],
                    views: ["line": line]
            )
            addConstraints(constraints)
        }
        if edges.contains(.Top) {
            addLineWithVisualFormatOfConstraints(horizontal: "H:|-0-[line]-0-|", vertical: "V:|-0-[line(width)]")
        }
        if edges.contains(.Right) {
            addLineWithVisualFormatOfConstraints(horizontal: "H:[line(width)]-0-|", vertical: "V:|-0-[line]-0-|")
        }
        if edges.contains(.Bottom) {
            addLineWithVisualFormatOfConstraints(horizontal: "H:|-0-[line]-0-|", vertical: "V:[line(width)]-0-|")
        }
        if edges.contains(.Left) {
            addLineWithVisualFormatOfConstraints(horizontal: "H:|-0-[line(width)]", vertical: "V:|-0-[line(width)]-0-|")
        }
    }
    
    func applyBoarder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.CGColor
        layer.borderWidth = width
    }
    
    func applyLayerRadius(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func applyCircleLayerRadius() {
        layer.masksToBounds = true
        layer.cornerRadius = height / 2
    }
    
    func applyCornerMask(corners: UIRectCorner = .AllCorners, radii: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radii)
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        layer.mask = mask
    }
}