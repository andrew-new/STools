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
    func leading() -> some View {
        HStack {
            self
            Spacer()
        }
    }
    func trailing() -> some View {
        HStack {
            Spacer()
            self
        }
    }
    func top() -> some View {
        VStack {
            self
            Spacer()
        }
    }
    func bottom() -> some View {
        VStack {
            Spacer()
            self
        }
    }
    func centerV() -> some View {
        VStack {
            Spacer()
            self
            Spacer()
        }
    }
    func centerH() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    func header<Content: View>(@ViewBuilder _ header: @escaping () -> Content, spacing: Double = 5) -> some View {
        VStack(spacing: spacing) {
            header()
            self
        }
    }
    func footer<Content: View>(@ViewBuilder _ footer: @escaping () -> Content, spacing: Double = 5) -> some View {
        VStack(spacing: spacing) {
            self
            footer()
        }
    }
    func leading<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        HStack {
            content()
            self
        }
    }
    func trailing<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        HStack {
            self
            content()
        }
    }
    @ViewBuilder func stateModifier<Content: View>(_ state: Binding<Bool>?, @ViewBuilder builder: (Self) -> Content) -> some View {
        if let state = state, state.wrappedValue {
            builder(self)
        }else {
            self
        }
    }
    func emptyState<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        return self.modifier(EmptyStateModifier(placeHolder: content()))
    }
}

#if canImport(AppKit)
public class Size {
    static var shared = Size()
    var size = (NSScreen.main?.visibleFrame ?? .zero).size
}
#endif
