//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
///STools: Apply conditional modifier to this view.
    @ViewBuilder func stateModifier<Content: View>(_ state: Bool?, @ViewBuilder builder: (Self) -> Content) -> some View {
        if let state = state, state {
            builder(self)
        }else {
            self
        }
    }
    #if swift(>=5.7)
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

#if os(macOS)
public class Size {
    public static var shared = Size()
    public var size = (NSScreen.main?.visibleFrame ?? .zero).size
}
#endif
