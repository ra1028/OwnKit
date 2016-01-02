//
//  UIView+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

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
        animations: () -> Void,
        completion: (Bool -> Void)? = nil) {
            animateWithDuration(duration, delay: delay, options: options, animations: animations, completion: completion)
    }
    
    static func animate(
        duration: NSTimeInterval,
        delay: NSTimeInterval = 0,
        springDamping: CGFloat,
        initialVelocity: CGFloat,
        options: UIViewAnimationOptions = [],
        animations: () -> Void,
        completion: (Bool -> Void)? = nil) {
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