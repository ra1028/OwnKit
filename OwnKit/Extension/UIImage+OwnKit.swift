//
//  UIImage+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/20/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIImage {
    func roundedImage(radius: CGFloat, size: CGSize? = nil) -> UIImage {
        let size = size ?? self.size
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        drawInRect(rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
    
    static func colorImage(
        color: UIColor,
        size: CGSize) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, Measure.screenScale)
            color.setFill()
            UIRectFill(CGRect(size: size))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
    }
    
    static func stringImage(
        string: String,
        font: UIFont,
        color: UIColor,
        size: CGSize? = nil) -> UIImage {
            let attributedString = Attribute(attribute: .Font(font))
                .add(.Color(color))
                .add(.Alignment(.Center))
                .string(string)
            
            let contextSize = size ?? CGSize(length: font.pointSize)
            UIGraphicsBeginImageContextWithOptions(contextSize, false, Measure.screenScale)
            let drawRect = CGRect(
                x: (contextSize.width - font.pointSize) / 2,
                y: (contextSize.height - font.pointSize) / 2,
                width: contextSize.width,
                height: contextSize.height
            )
            attributedString.drawInRect(drawRect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
    }
}