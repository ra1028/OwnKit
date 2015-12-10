//
//  UIColor+Util.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIColor {
    var hue: CGFloat {
        var h: CGFloat = 0
        self.getHue(&h, saturation: nil, brightness: nil, alpha: nil)
        return h
    }
    
    var saturation: CGFloat {
        var s: CGFloat = 0
        self.getHue(nil, saturation: &s, brightness: nil, alpha: nil)
        return s
    }
    
    var brightness: CGFloat {
        var b: CGFloat = 0
        self.getHue(nil, saturation: nil, brightness: &b, alpha: nil)
        return b
    }
    
    var white: CGFloat {
        var w: CGFloat = 0
        self.getWhite(&w, alpha: nil)
        return w
    }
    
    var red: CGFloat {
        var r: CGFloat = 0
        self.getRed(&r, green: nil, blue: nil, alpha: nil)
        return r
    }
    
    var green: CGFloat {
        var g: CGFloat = 0
        self.getRed(nil, green: &g, blue: nil, alpha: nil)
        return g
    }
    
    var blue: CGFloat {
        var b: CGFloat = 0
        self.getRed(nil, green: nil, blue: &b, alpha: nil)
        return b
    }
    
    var alpha: CGFloat {
        var a: CGFloat = 0
        self.getWhite(nil, alpha: &a)
        return a
    }
    
    func alphaColor(alpha: CGFloat) -> UIColor {
        return self.colorWithAlphaComponent(alpha)
    }
    
    func blendColor(aColor: UIColor, ratio: CGFloat = 0.5) -> UIColor {
        let mainRatio = ratio
        let red = self.red * mainRatio + aColor.red * ratio
        let green = self.green * mainRatio + aColor.green * ratio
        let blue = self.blue * mainRatio + aColor.blue * ratio
        let alpha = self.alpha * mainRatio + aColor.alpha * ratio
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func brightColor(brightten: CGFloat) -> UIColor {
        return UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness * brightten, alpha: self.alpha)
    }
    
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat( hex3 & 0x00F ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat( hex4 & 0x000F ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat( hex6 & 0x0000FF ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let alpha = CGFloat( hex8 & 0x000000FF ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        var rgbInt: UInt64 = 0
        let trimHex = hexString.stringByReplacingOccurrencesOfString("[^0-9a-fA-F]", withString: "", options: .RegularExpressionSearch)
        NSScanner(string: trimHex).scanHexLongLong(&rgbInt)
        let red = CGFloat((rgbInt & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbInt & 0x00FF00) >> 8)/255.0
        let blue = CGFloat(rgbInt & 0x0000FF)/255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}