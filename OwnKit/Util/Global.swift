//
//  Global.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/28/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public func ratioValue(min minValue: CGFloat, max maxValue: CGFloat, minRatio: CGFloat = 0, maxRatio: CGFloat = 1, ratio: CGFloat) -> CGFloat {
    let ratio = max(minRatio, min(maxRatio, ratio))
    return maxValue - (maxValue - minValue) * ratio
}