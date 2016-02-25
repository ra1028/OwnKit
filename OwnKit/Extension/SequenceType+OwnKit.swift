//
//  SequenceType+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 2/21/16.
//  Copyright © 2016 Ryo Aoyama. All rights reserved.
//

public extension SequenceType {
    func enumerateEach(@noescape body: (Int, Generator.Element) -> Void) {
        enumerate().forEach(body)
    }
    
    func enumerateMap<T>(@noescape transform: (Int, Generator.Element) -> T) -> [T] {
        return enumerate().map(transform)
    }
}