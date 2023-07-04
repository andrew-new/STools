//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI


public extension View {
#if canImport(UIKit)
    @available(iOS, introduced: 13.0, deprecated: 16.0, message: "Use the screenSize EnvironmentKey instead")
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    @available(iOS, introduced: 13.0, deprecated: 16.0, message: "Use the screenSize EnvironmentKey instead")
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
#endif
///STools: Pin this view to an Edge.
    @ViewBuilder func pin(to edge: Edge) -> some View {
        switch edge {
            case .top:
                self
                    .frame(maxHeight: .infinity, alignment: .top)
            case .leading:
                self
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .bottom:
                self
                    .frame(maxHeight: .infinity, alignment: .bottom)
            case .trailing:
                self
                    .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
///STools: Center the view along an axis.
    @ViewBuilder func center(_ axis: ViewAxis) -> some View {
        switch axis {
            case .horizontal:
                self
                    .frame(maxWidth: .infinity, alignment: .center)
            case .vertical:
                self
                    .frame(maxHeight: .infinity, alignment: .center)
        }
    }
///STools: Apply conditional modifier to this view.
    @ViewBuilder func state<Content: View>(_ state: Bool?, @ViewBuilder builder: (Self) -> Content) -> some View {
        if let state = state, state {
            builder(self)
        }else {
            self
        }
    }
///STools: Pin this view relative to another.
    func alignment<Content: View>(edge: Edge, spacing: CGFloat? = nil, expand: Bool = false, @ViewBuilder view: @escaping () -> Content) -> some View {
        alignment(edge: edge, spacing: spacing, expand: expand, view: view())
    }
///STools: Pin this view relative to another.
    @ViewBuilder func alignment<Content: View>(edge: Edge, spacing: CGFloat? = nil, expand: Bool = false, view: Content) -> some View {
        switch edge {
            case .top:
                VStack(spacing: spacing) {
                    view
                    if expand {
                        Spacer()
                    }
                    self
                }
            case .leading:
                HStack(spacing: spacing) {
                    view
                    if expand {
                        Spacer()
                    }
                    self
                }
            case .bottom:
                VStack(spacing: spacing) {
                    self
                    if expand {
                        Spacer()
                    }
                    view
                }
            case .trailing:
                HStack(spacing: spacing) {
                    self
                    if expand {
                        Spacer()
                    }
                    view
                }
        }
    }
    @ViewBuilder func hidden(_ value: Bool) -> some View {
        if !value {
            self
        }
    }
    func hidden(_ value: () -> Bool) -> some View {
        hidden(value())
    }
}
