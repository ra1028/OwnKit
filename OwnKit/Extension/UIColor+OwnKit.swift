//
//  UIColor+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public extension UIColor {
    var hue: CGFloat {
        var h: CGFloat = 0
        getHue(&h, saturation: nil, brightness: nil, alpha: nil)
        return h
    }
    
    var saturation: CGFloat {
        var s: CGFloat = 0
        getHue(nil, saturation: &s, brightness: nil, alpha: nil)
        return s
    }
    
    var brightness: CGFloat {
        var b: CGFloat = 0
        getHue(nil, saturation: nil, brightness: &b, alpha: nil)
        return b
    }
    
    var white: CGFloat {
        var w: CGFloat = 0
        getWhite(&w, alpha: nil)
        return w
    }
    
    var red: CGFloat {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return r
    }
    
    var green: CGFloat {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return g
    }
    
    var blue: CGFloat {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return b
    }
    
    var alpha: CGFloat {
        var a: CGFloat = 0
        getWhite(nil, alpha: &a)
        return a
    }
    
    func alphaColor(alpha: CGFloat) -> UIColor {
        return colorWithAlphaComponent(alpha)
    }
    
    func blendColor(aColor: UIColor, ratio: CGFloat = 0.5) -> UIColor {
        let ratio = min(1, max(0, ratio))
        let mainRatio = 1 - ratio
        let r = red * mainRatio + aColor.red * ratio
        let g = green * mainRatio + aColor.green * ratio
        let b = blue * mainRatio + aColor.blue * ratio
        let a = alpha * mainRatio + aColor.alpha * ratio
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func brightColor(brighten: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness * brighten, alpha: alpha)
    }
    
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = 15.f
        let r = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let g = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let b = CGFloat( hex3 & 0x00F ) / divisor
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex4: UInt16) {
        let divisor = 15.f
        let r = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let g = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let b = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let a = CGFloat( hex4 & 0x000F ) / divisor
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = 255.f
        let r = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let g = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let b = CGFloat( hex6 & 0x0000FF ) / divisor
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex8: UInt32) {
        let divisor = 255.f
        let r = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let g = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let b = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let a = CGFloat( hex8 & 0x000000FF ) / divisor
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(hexString: String) {
        var hex = 0.u32
        let trimmedHex = hexString.removeRegex("[^0-9a-fA-F]")
        NSScanner(string: trimmedHex).scanHexInt(&hex)
        self.init(hex6: hex)
    }
}