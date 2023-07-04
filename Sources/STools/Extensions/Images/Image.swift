//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension Image {
    init(data: Data?) {
        self.init("")
        if let data = data, let image = UNImage(data: data) {
            self.init(unImage: image)
        }
    }
    init(unImage: UNImage) {
#if canImport(UIKit)
        self.init(uiImage: unImage)
#elseif canImport(AppKit)
        self.init(nsImage: unImage)
#endif
    }
}
