//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
    var width: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.width
#elseif canImport(AppKit)
        return Size.shared.size.width
#endif
    }
    var height: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.height
#elseif canImport(AppKit)
        return Size.shared.size.height
#endif
    }
///STools: Apply conditional modifier to this view.
    @ViewBuilder func stateModifier<Content: View>(_ state: Bool?, @ViewBuilder builder: (Self) -> Content) -> some View {
        if let state = state, state {
            builder(self)
        }else {
            self
        }
    }
    #if canImport(Charts) 
///STools: Listen to changes made to multiple properties.
    @ViewBuilder func onChange(of values: any Equatable..., completion: @escaping () -> Void) -> some View {
        self
            .onReceive(values.publisher) { newValue in
                completion()
            }
    }
    #endif
///STools: Display a placeholder when this view is empty.
    @ViewBuilder func emptyState<Content: View>(_ shouldEmpty: Bool = false, @ViewBuilder content: () -> Content) -> some View {
        self.modifier(EmptyStateModifier(placeHolder: content(), shouldEmpty: shouldEmpty))
    }
}

#if canImport(AppKit)
public class Size {
    public static var shared = Size()
    public var size = (NSScreen.main?.visibleFrame ?? .zero).size
}
#endif
