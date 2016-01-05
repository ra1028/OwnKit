//
//  UIImage+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/20/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIImage {
    func roundedImage(radius: CGFloat) -> UIImage {
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: radius * scale).addClip()
        drawInRect(rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}