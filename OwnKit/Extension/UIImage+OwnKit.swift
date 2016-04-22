//
//  UIImage+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/20/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import Accelerate

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
    
    func blurredImage(radius: CGFloat, iterations: Int = 1, ratio: CGFloat = 1, blendColor: UIColor? = nil) -> UIImage {
        if floorf(Float(size.width)) * floorf(Float(size.height)) <= 0.0 || radius <= 0 {
            return self
        }
        
        let imageRef = CGImage
        var boxSize = UInt32(radius * scale * ratio)
        if boxSize % 2 == 0 { boxSize += 1 }
        
        let height = CGImageGetHeight(imageRef)
        let width = CGImageGetWidth(imageRef)
        let rowBytes = CGImageGetBytesPerRow(imageRef)
        let bytes = rowBytes * height
        
        let inData = malloc(bytes)
        var inBuffer = vImage_Buffer(data: inData, height: UInt(height), width: UInt(width), rowBytes: rowBytes)
        
        let outData = malloc(bytes)
        var outBuffer = vImage_Buffer(data: outData, height: UInt(height), width: UInt(width), rowBytes: rowBytes)
        
        let tempFlags = vImage_Flags(kvImageEdgeExtend + kvImageGetTempBufferSize)
        let tempSize = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, boxSize, boxSize, nil, tempFlags)
        let tempBuffer = malloc(tempSize)
        
        let provider = CGImageGetDataProvider(imageRef)
        let copy = CGDataProviderCopyData(provider)
        let source = CFDataGetBytePtr(copy)
        memcpy(inBuffer.data, source, bytes)
        
        let flags = vImage_Flags(kvImageEdgeExtend)
        
        iterations.times { _ in
            vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, tempBuffer, 0, 0, boxSize, boxSize, nil, flags)
            
            let temp = inBuffer.data
            inBuffer.data = outBuffer.data
            outBuffer.data = temp
        }
        
        let colorSpace = CGImageGetColorSpace(imageRef)
        let bitmapInfo = CGImageGetBitmapInfo(imageRef)
        let bitmapContext = CGBitmapContextCreate(inBuffer.data, width, height, 8, rowBytes, colorSpace, bitmapInfo.rawValue)
        defer {
            free(outBuffer.data)
            free(tempBuffer)
            free(inBuffer.data)
        }
        
        if let color = blendColor {
            CGContextSetFillColorWithColor(bitmapContext, color.CGColor)
            CGContextSetBlendMode(bitmapContext, CGBlendMode.PlusLighter)
            CGContextFillRect(bitmapContext, CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        if let bitmap = CGBitmapContextCreateImage(bitmapContext) {
            return UIImage(CGImage: bitmap, scale: scale, orientation: imageOrientation)
        }
        
        fatalError()
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
            let attributedString = Attribute(.Font(font))
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