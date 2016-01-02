//
//  InteractivePoppable.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/2/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

import Foundation

public protocol InteractivePoppable: UIGestureRecognizerDelegate {}

public extension InteractivePoppable where Self: UIViewController {
    func setIntaractivePopEnable() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}