//
//  AttributedString.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/12/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public enum StringAttributes {
    case Font(UIFont)
    case Color(UIColor)
    case BaselineOffset(Float)
    case ParagraphStyle(NSParagraphStyle)
    case UnderlineStyle(NSUnderlineStyle)
    case Kern(CGFloat)
    case Link(NSURL)
    
    var name: String {
        switch self {
        case .Font: return NSFontAttributeName
        case .Color: return NSForegroundColorAttributeName
        case .BaselineOffset: return NSBaselineOffsetAttributeName
        case .ParagraphStyle: return NSParagraphStyleAttributeName
        case .UnderlineStyle: return NSUnderlineStyleAttributeName
        case .Kern: return NSKernAttributeName
        case .Link: return NSLinkAttributeName
        }
    }
}

public struct Attribute {
    private let originalString: String
    private let attributedString: NSMutableAttributedString
    
    var string: NSAttributedString {
        return NSAttributedString(attributedString: attributedString)
    }
    
    init(_ originalString: String, attributes: [StringAttributes] = []) {
        self.originalString = originalString
        attributedString = NSMutableAttributedString(string: originalString)
        add(attributes)
    }
    
    func add(attribute: StringAttributes, range: Range<Int>? = nil) -> Attribute {
        let nsRange: NSRange
        if let range = range {
            nsRange = NSRange(range)
        } else {
            nsRange = NSRange(location: 0, length: originalString.length)
        }
        switch attribute {
        case .Font(let font):
            attributedString.addAttribute(attribute.name, value: font, range: nsRange)
        case .Color(let color):
            attributedString.addAttribute(attribute.name, value: color, range: nsRange)
        case .BaselineOffset(let offset):
            attributedString.addAttribute(attribute.name, value: offset, range: nsRange)
        case .ParagraphStyle(let style):
            attributedString.addAttribute(attribute.name, value: style, range: nsRange)
        case .UnderlineStyle(let style):
            attributedString.addAttribute(attribute.name, value: style.rawValue, range: nsRange)
        case .Kern(let kern):
            attributedString.addAttribute(attribute.name, value: kern, range: nsRange)
        case .Link(let url):
            attributedString.addAttribute(attribute.name, value: url, range: nsRange)
        }
        return self
    }
    
    func add(attributes: [StringAttributes], range: Range<Int>? = nil) -> Attribute {
        attributes.forEach { add($0, range: range) }
        return self
    }
}