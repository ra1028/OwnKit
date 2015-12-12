//
//  UIView+OwnKit.swift
//  OwnedKit
//
//  Created by Ryo Aoyama on 12/6/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIView {
    static func instantiate() -> Self {        
        return UINib.instantiate(self)
    }
    
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
}