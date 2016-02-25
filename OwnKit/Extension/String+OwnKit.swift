//
//  String+OwnKit.swift
//  Pods
//
//  Created by Ryo Aoyama on 12/6/15.
//
//

import UIKit

public extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var length: Int {
        return characters.count
    }
    
    static func classNameOf(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).separate(".").last!
    }
    
    func range(fromIndex: Int? = nil, toIndex: Int? = nil) -> Range<Index> {
        guard let toIndex = toIndex else {
            return startIndex.advancedBy(fromIndex ?? 0)..<endIndex
        }
        return startIndex.advancedBy(fromIndex ?? 0)..<startIndex.advancedBy(toIndex)
    }
    
    func rangeOfString(aString: String) -> Range<Int>? {
        return Regex(aString)?.firstMatchResult(self)?.range.toRange()
    }
    
    func removeSpaces() -> String {
        return removeRegex("　| |\t")
    }
    
    func removeLineBreaks() -> String {
        return removeRegex("\n|\r|\\f|\\v")
    }
    
    func removeSpaceAndLineBreaks() -> String {
        return removeRegex("\\s")
    }
    
    func trimSpaces() -> String {
        return stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func firstMatchRegex(regex: String, options: NSMatchingOptions = [], range: Range<Int>? = nil) -> String {
        return Regex(regex)?.firstMatchString(self, options: options, range: range) ?? ""
    }
    
    func replace(target: String, toString: String, options: NSStringCompareOptions = [], range: Range<Int>? = nil) -> String {
        let range = range.map { self.range($0.startIndex, toIndex: $0.endIndex) }
        return stringByReplacingOccurrencesOfString(target, withString: toString,options: options, range: range)
    }
    
    func replaceRegex(regex: String, toString: String, range: Range<Int>? = nil) -> String {
        return replace(regex, toString: toString, options: .RegularExpressionSearch, range: range)
    }
    
    func remove(target: String, range: Range<Int>? = nil) -> String {
        return replace(target, toString: "", range: range)
    }
    
    func removeRegex(regex: String, range: Range<Int>? = nil) -> String {
        return replaceRegex(regex, toString: "", range: range)
    }
    
    func separate(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
    
    func eachLine(@noescape body: String -> ()) {
        separate("\n").forEach(body)
    }
    
    func mapLine(@noescape transform: String -> String) -> String {
        return separate("\n").map(transform).joinWithSeparator("\n")
    }
    
    func prefixUpTo(index: Int) -> String? {
        guard length > index else {
            return nil
        }
        let index = characters.startIndex.advancedBy(index)
        return substringToIndex(index)
    }
    
    func prefixUpTo(aString: String) -> String? {
        let separated = separate(aString)
        guard let prefix = separated.first where separated.count > 1 else {
            return nil
        }
        return prefix
    }
    
    func prefixThrough(index: Int) -> String? {
        guard length > index else  {
            return nil
        }
        let index = characters.startIndex.advancedBy(index)
        return String(characters.prefixThrough(index))
    }
    
    func prefixThrough(aString: String) -> String? {
        guard let prefix = prefixUpTo(aString) else {
            return nil
        }
        return prefix + aString
    }
    
    func suffixThrough(index: Int) -> String? {
        guard length > index else {
            return nil
        }
        return substringWithRange(range(index))
    }
    
    func suffixThrough(aString: String) -> String? {
        guard let suffix = suffixAfter(aString) else {
            return nil
        }
        return aString + suffix
    }
    
    func suffixAfter(index: Int) -> String? {
        let afterIndex = index + 1
        guard characters.count > afterIndex else {
            return nil
        }
        return substringFromIndex(Index(index + 1))
    }
    
    func suffixAfter(aString: String) -> String? {
        let separated = separate(aString)
        guard let suffix = separated.last where separated.count > 1 else {
            return nil
        }
        return suffix
    }
    
    func decodeFromBase64() -> String? {
        if let data = NSData(base64EncodedString: self, options: .IgnoreUnknownCharacters) {
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        return nil
    }
}
