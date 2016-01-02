//
//  Measure.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/11/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public struct Measure {}

public extension Measure {
    static var statusBarHeight: CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.height
    }
    
    static var screenScale: CGFloat {
        return UIScreen.mainScreen().scale
    }
    
    static var screenSize: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    static var isPhone: Bool {
        return UIDevice.currentDevice().isPhone
    }
    
    static var isPad: Bool {
        return UIDevice.currentDevice().isPad
    }
    
    static var deviceSize: CGSize {
        return UIDevice.currentDevice().size
    }
    
    static var deviceHeight: CGFloat {
        return UIDevice.currentDevice().height
    }
    
    static var diviceWidth: CGFloat {
        return UIDevice.currentDevice().width
    }
    
    static var isPortrait: Bool {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        return orientation == .Portrait || orientation == .PortraitUpsideDown
    }
    
    static var isLandscape: Bool {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        return orientation == .LandscapeLeft || orientation == .LandscapeRight
    }
    
    static func isDeviceSize(height: UIDevice.DeviceHeight) -> Bool {
        return UIDevice.currentDevice().isSize(height)
    }
    
    static func isDeviceSizeOrLarger(height: UIDevice.DeviceHeight) -> Bool {
        return UIDevice.currentDevice().isSizeOrLarger(height)
    }
    
    static func isDeviceSizeOrSmaller(height: UIDevice.DeviceHeight) -> Bool {
        return UIDevice.currentDevice().isSizeOrSmaller(height)
    }
}

public extension Measure {
    // MARK: 3.5 Inch
    
    static var is3_5Inches: Bool {
        return UIDevice.currentDevice().is3_5Inches
    }
    static var is3_5InchesOrLarger: Bool {
        return UIDevice.currentDevice().is3_5InchesOrLarger
    }
    static var is3_5InchesOrSmaller: Bool {
        return UIDevice.currentDevice().is3_5InchesOrSmaller
    }
    
    // MARK: 4 Inch
    
    static var is4Inches: Bool {
        return UIDevice.currentDevice().is4Inches
    }
    static var is4InchesOrLarger: Bool {
        return UIDevice.currentDevice().is4InchesOrLarger
    }
    static var is4InchesOrSmaller: Bool {
        return UIDevice.currentDevice().is4InchesOrSmaller
    }
    
    // MARK: 4.7 Inch
    
    static var is4_7Inches: Bool {
        return UIDevice.currentDevice().is4_7Inches
    }
    static var is4_7InchesOrLarger: Bool {
        return UIDevice.currentDevice().is4_7InchesOrLarger
    }
    static var is4_7InchesOrSmaller: Bool {
        return UIDevice.currentDevice().is4_7InchesOrSmaller
    }
    
    // MARK: 5.5 Inch
    
    static var is5_5Inches: Bool {
        return UIDevice.currentDevice().is5_5Inches
    }
    static var is5_5InchesOrLarger: Bool {
        return UIDevice.currentDevice().is5_5InchesOrLarger
    }
    static var is5_5InchesOrSmaller: Bool {
        return UIDevice.currentDevice().is5_5InchesOrSmaller
    }
}