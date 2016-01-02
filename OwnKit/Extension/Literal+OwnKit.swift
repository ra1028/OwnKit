//
//  Literal+OwnKit.swift
//  OwnKit
//
//  Created by Ryo Aoyama on 12/31/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

public extension IntegerLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
    
    var u8: UInt8 {
        return UInt8(self)
    }
    
    var u16: UInt16 {
        return UInt16(self)
    }
    
    var u32: UInt32 {
        return UInt32(self)
    }
    
    var u64: UInt64 {
        return UInt64(self)
    }
}

public extension FloatLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
}
