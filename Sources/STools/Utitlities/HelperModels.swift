//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

#if canImport(UIKit)
public typealias UNImage = UIImage
#elseif canImport(AppKit)
public typealias UNImage = NSImage
#endif
#if canImport(UIKit)
public typealias UNColor = UIColor
#elseif canImport(AppKit)
public typealias UNColor = NSColor
#endif
#if canImport(UIKit)
public typealias UNView = UIView
#elseif canImport(AppKit)
public typealias UNView = NSView
#endif
#if canImport(GroupActivities)
public typealias ContentShape = ShapeStyle
#else
public typealias ContentShape = View
#endif

public enum ImageQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
}

public enum SizeChange: Int {
    case height, width
}

public enum DateInterval {
    case day, week, month, year
}

public enum ViewAxis {
    case horizontal, vertical
}

public enum SwipeEdge {
    case leading, trailing
    @available(iOS 15.0, macOS 12.0, *)
    public var horizontalEdge: HorizontalEdge {
        return self == .leading ? .leading: .trailing
    }
}
