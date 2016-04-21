//
//  Regex.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/11/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

public struct Regex {
    private let matcher: NSRegularExpression
}

public extension Regex {
    init?(_ pattern: String, options: NSRegularExpressionOptions = []) {
        do {
            matcher = try NSRegularExpression(pattern: pattern, options: options)
        } catch {
            matcher = NSRegularExpression()
            return nil
        }
    }
    
    func match(target: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> Bool {
        return matchResults(target, options: options, range: range).isNotEmpty
    }
    
    func firstMatchString(target: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> String? {
        return firstMatchResult(target, options: options, range: range).flatMap {
            $0.range.toRange().map {
                let range = target.range($0.startIndex, toIndex: $0.endIndex)
                return target.substringWithRange(range)
            }
        }
    }
    
    func replaceMatches(target: String, toString: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> String {
        if let range = range {
            return matcher.stringByReplacingMatchesInString(target, options: options, range: NSRange(range), withTemplate: toString)
        } else {
            return matcher.stringByReplacingMatchesInString(target, options: options, range: NSRange(location: 0, length: target.length), withTemplate: toString)
        }
    }
    
    func removeMatches(target: String, range: Range<Int>? = nil) -> String {
        return replaceMatches(target, toString: "", range: range)
    }
    
    func firstMatchResult(target: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> NSTextCheckingResult? {
        if let range = range {
            return matcher.firstMatchInString(target, options: options, range: NSRange(range))
        }
        return matcher.firstMatchInString(target, options: options, range: NSRange(location: 0, length: target.length))
    }
    
    func matchResults(target: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> [NSTextCheckingResult] {
        if let range = range {
            return matcher.matchesInString(target, options: options, range: NSRange(range))
        }
        return matcher.matchesInString(target, options: options, range: NSRange(location: 0, length: target.length))
    }
}

infix operator =~ { associativity left precedence 130 }

public func =~(regex: Regex, target: String) -> Bool {
    return regex.match(target)
}

public func =~(pattern: String, target: String) -> Bool {
    if let regex = Regex(pattern) {
        return regex =~ pattern
    } else {
        return false
    }
}