//
//  File 2.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import Foundation

extension SignedInteger {
    var int: Int {
        return Int(self)
    }
    var int64: Int64 {
        return Int64(self)
    }
    var int32: Int32 {
        return Int32(self)
    }
    var string: String {
        return String(self)
    }
    var double: Double {
        return Double(self)
    }
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension BinaryFloatingPoint {
    var int: Int {
        return Int(self)
    }
    var int64: Int64 {
        return Int64(self)
    }
    var int32: Int32 {
        return Int32(self)
    }
    var string: String {
        return String(self.double)
    }
    var double: Double {
        return Double(self)
    }
}
