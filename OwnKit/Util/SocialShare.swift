//
//  Share.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2/28/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import UIKit
import Social

public struct Share {
    public enum Social: String {
        case Facebook
        case Twitter
        
        public var serviceType: String {
            switch self {
            case .Facebook: return SLServiceTypeFacebook
            case .Twitter: return SLServiceTypeTwitter
            }
        }
        
        public var isAvailable: Bool {
            return SLComposeViewController.isAvailableForServiceType(serviceType)
        }
        
        public func composeViewController(text text: String? = nil, image: UIImage? = nil, url: NSURL? = nil) -> SLComposeViewController {            
            return SLComposeViewController(forServiceType: serviceType).tweak { vc in
                text.some { vc.setInitialText($0) }
                image.some { vc.addImage($0) }
                url.some { vc.addURL($0) }
            }
        }
        
        public func present(inViewController: UIViewController, text: String? = nil, image: UIImage? = nil, url: NSURL? = nil) {
            let vc = composeViewController(text: text, image: image, url: url)
            inViewController.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    public struct Activity {
        public static func activityViewController(items: [AnyObject], activitys: [UIActivity]? = nil, excludedTypes: [String]? = nil) -> UIActivityViewController {
            return UIActivityViewController(activityItems: items, applicationActivities: activitys).tweak {
                $0.excludedActivityTypes = excludedTypes
            }
        }
        
        public static func present(inViewController: UIViewController, items: [AnyObject], activitys: [UIActivity]? = nil, excludedTypes: [String]? = nil) {
            let vc = activityViewController(items, activitys: activitys, excludedTypes: excludedTypes)
            inViewController.presentViewController(vc, animated: true, completion: nil)
        }
    }
}