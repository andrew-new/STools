//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

#if canImport(UIKit)
extension UIUserInterfaceStyle {
    var colorScheme: ColorScheme {
        return  self == .dark ? .dark: .light
    }
}
#endif
