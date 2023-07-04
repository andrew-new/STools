//
//  File.swift
//  
//
//  Created by Joe Maghzal on 04/07/2023.
//

import SwiftUI

internal struct ScreenSizeKey: EnvironmentKey {
    internal static let defaultValue = CGSize.zero
}

public extension EnvironmentValues {
    var screenSize: CGSize {
        get {
            self[ScreenSizeKey.self]
        }
        set {
            self[ScreenSizeKey.self] = newValue
        }
    }
}

public extension View {
    func sizeListener() -> some View {
        GeometryReader { geometryProxy in
            self
                .environment(\.screenSize, geometryProxy.size)
        }
    }
}
