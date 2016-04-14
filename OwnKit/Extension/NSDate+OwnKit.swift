//
//  NSDate+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/22/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import Foundation

public extension NSDate {
    static func systemLocaleDate(dateString: String, format: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.locale = .systemLocale()
        formatter.timeZone = .localTimeZone()
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
    
    static func date(
        dateString: String,
        format: String,
        locale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX"),
        timeZone: NSTimeZone = .localTimeZone()) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter.dateFromString(dateString)
    }
    
    func string(format: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
    func mediumStyleNoTime(locale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        formatter.locale = locale
        return formatter.stringFromDate(self)
    }
}