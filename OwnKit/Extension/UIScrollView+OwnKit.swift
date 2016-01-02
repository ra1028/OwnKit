//
//  UIScrollView+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/21/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIScrollView {
    var contentHeight: CGFloat {
        return contentSize.height
    }
    
    var contentWidth: CGFloat {
        return contentSize.width
    }
    
    func scrollToTop(animated animated: Bool) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }
    
    func scrollToBottom(animated animated: Bool) {
        setContentOffset(CGPoint(x: contentOffset.x, y: contentSize.height - height), animated: animated)
    }
}