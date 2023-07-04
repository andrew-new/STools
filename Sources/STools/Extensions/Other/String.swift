//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import AVKit

public extension String {
    var unColor: UNColor {
        var cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            return UNColor.gray
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UNColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0)
        )
    }
    var color: Color {
        Color(hex: self)
    }
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    var int: Int? {
        return Int(self)
    }
    var int64: Int64? {
        return Int64(self)
    }
    var int32: Int32? {
        return Int32(self)
    }
    var double: Double? {
        return Double(self)
    }
}
