//
//  DiscardBag.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 1/15/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

public extension Discardable {
    func addDiscardableTo(bag: DiscardBag) {
        bag.addDiscardable(self)
    }
}

public class DiscardBag {
    private var discardables = [Discardable]()
    private var discarded = false
    
    public init() {}
    
    deinit {
        discard()
    }
}

public extension DiscardBag {
    func addDiscardable(discardable: Discardable) {
        if discarded {
            discardable.discard()
            return
        }
        discardables.append(discardable)
    }
    
    func discard() {
        discardables.forEach { $0.discard() }
        discardables.removeAll()
        discarded = true
    }
}