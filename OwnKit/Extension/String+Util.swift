//
//  String+Util.swift
//  Pods
//
//  Created by Ryo Aoyama on 12/6/15.
//
//

public extension String {
    var removeSpace: String {
        return stringByReplacingOccurrencesOfString("( |\n)", withString: "", options: .RegularExpressionSearch)
    }
    
    var trimSpace: String {
        return stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func separate(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
    
    func prefixUpTo(index: Int) -> String? {
        guard characters.count > index else {
            return nil
        }
        let index = characters.startIndex.advancedBy(index)
        return substringToIndex(index)
    }
    
    func prefixUpTo(aString: String) -> String? {
        let components = componentsSeparatedByString(aString)
        guard let prefix = components.first where components.count > 1 else {
            return nil
        }
        return prefix
    }
    
    func prefixThrough(index: Int) -> String? {
        guard characters.count > index else  {
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
    
    func suffixFrom(index: Int) -> String? {
        guard characters.count > index else {
            return nil
        }
        let index = characters.startIndex.advancedBy(index)
        return substringWithRange(Range<Index>(start: index, end: characters.endIndex))
    }
    
    func suffixFrom(aString: String) -> String? {
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
        let index = characters.startIndex.advancedBy(afterIndex)
        return substringFromIndex(index)
    }
    
    func suffixAfter(aString: String) -> String? {
        let components = componentsSeparatedByString(aString)
        guard let suffix = components.last where components.count > 1 else {
            return nil
        }
        return suffix
    }
}