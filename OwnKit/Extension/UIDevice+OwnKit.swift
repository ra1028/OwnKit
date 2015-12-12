//
//  UIDevice+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/11/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension UIDevice {
    enum DeviceHeight: CGFloat {
        case Inches3_5 = 480
        case Inches4 = 568
        case Inches4_7 = 667
        case Inches5_5 = 736
    }
    
    var isPhone: Bool {
        return userInterfaceIdiom == .Phone
    }
    
    var isPad: Bool {
        return userInterfaceIdiom == .Pad
    }
    
    var size: CGSize {
        return CGSize(width: width, height: height)
    }
    
    var height: CGFloat {
        return Measure.isPortrait ? Measure.screenHeight : Measure.screenWidth
    }
    
    var width: CGFloat {
        return Measure.isPortrait ? Measure.screenHeight : Measure.screenWidth
    }
    
    func isSize(height: DeviceHeight) -> Bool {
        return self.height == height.rawValue
    }
    
    func isSizeOrLarger(height: DeviceHeight) -> Bool {
        return self.height >= height.rawValue
    }
    
    func isSizeOrSmaller(height: DeviceHeight) -> Bool {
        return self.height <= height.rawValue
    }
    
    var isPortrait: Bool {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        return orientation == .Portrait || orientation == .PortraitUpsideDown
    }
    
    var isLandscape: Bool {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        return orientation == .LandscapeLeft || orientation == .LandscapeRight
    }
}

public extension UIDevice {
    // MARK: 3.5 Inch
    
    var is3_5Inches: Bool {
        return isPhone && isSize(.Inches3_5)
    }
    var is3_5InchesOrLarger: Bool {
        return isPhone && isSizeOrLarger(.Inches3_5)
    }
    var is3_5InchesOrSmaller: Bool {
        return isPhone && isSizeOrSmaller(.Inches3_5)
    }
    
    // MARK: 4 Inch
    
    var is4Inches: Bool {
        return isPhone && isSize(.Inches4)
    }
    var is4InchesOrLarger: Bool {
        return isPhone && isSizeOrLarger(.Inches4)
    }
    var is4InchesOrSmaller: Bool {
        return isPhone && isSizeOrSmaller(.Inches4)
    }
    
    // MARK: 4.7 Inch
    
    var is4_7Inches: Bool {
        return isPhone && isSize(.Inches4_7)
    }
    var is4_7InchesOrLarger: Bool {
        return isPhone && isSizeOrLarger(.Inches4_7)
    }
    var is4_7InchesOrSmaller: Bool {
        return isPhone && isSizeOrSmaller(.Inches4_7)
    }
    
    // MARK: 5.5 Inch
    
    var is5_5Inches: Bool {
        return isPhone && isSize(.Inches5_5)
    }
    var is5_5InchesOrLarger: Bool {
        return isPhone && isSizeOrLarger(.Inches5_5)
    }
    var is5_5InchesOrSmaller: Bool {
        return isPhone && isSizeOrSmaller(.Inches5_5)
    }
}