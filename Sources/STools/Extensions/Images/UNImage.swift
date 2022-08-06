//
//  File 2.swift
//  
//
//  Created by Joe Maghzal on 7/30/22.
//

import SwiftUI

public extension UNImage {
    func asData(_ quality: ImageQuality) -> Data? {
#if canImport(UIKit)
        return jpegData(compressionQuality: quality.rawValue)
#elseif canImport(AppKit)
        return tiffRepresentation
#endif
    }
}
