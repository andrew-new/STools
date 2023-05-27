//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

public extension View {
    var screenWidth: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.width
#elseif canImport(AppKit)
        return Size.shared.size.width
#endif
    }
    var screenHeight: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.bounds.height
#elseif canImport(AppKit)
        return Size.shared.size.height
#endif
    }
///STools: Adjust this view's frame with a fallback frame.
    @ViewBuilder func framey(width: CGFloat, height: CGFloat, masterWidth: CGFloat? = nil, masterHeight: CGFloat? = nil, master: Bool) -> some View {
        self
            .frame(width: master ? (masterWidth ?? width): width, height:  master ? (masterHeight ?? height): height)
    }
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
                    .frame(maxWidth: .infinity, alignment: .leading)
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
///STools: Pin this view relative to another.
    @ViewBuilder func alignment<Content: View>(edge: Edge, spacing: CGFloat? = nil, expand: Bool = false, @ViewBuilder view: @escaping () -> Content) -> some View {
        self
            .alignment(edge: edge, spacing: spacing, expand: expand, view: view())
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
    @ViewBuilder func onChange(of element: SizeChange, action: @escaping (CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { reader in
                    Color.clear
                        .onAppear {
                            action(reader.frame(in: .global).height)
                        }.change(of: element == .height ? reader.frame(in: .global).height: reader.frame(in: .global).width) { newValue in
                            action(newValue)
                        }
                }
            )
    }
    @ViewBuilder func onChange(of element: SizeChange, newValue: Binding<CGFloat>) -> some View {
        self
            .onChange(of: element) { value in
                newValue.wrappedValue = value
            }
    }
    @ViewBuilder func onSizeChange(action: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader { reader in
                    Color.clear
                        .onAppear {
                            action(reader.frame(in: .global).size)
                        }.change(of: reader.frame(in: .global).size) { newValue in
                            action(newValue)
                        }
                }
            )
    }
    @ViewBuilder func onSizeChange(newValue: Binding<CGSize>) -> some View {
        self
            .onSizeChange { value in
                newValue.wrappedValue = value
            }
    }
    @ViewBuilder func hidden(_ value: Bool) -> some View {
        if !value {
            self
        }
    }
    @ViewBuilder func hidden(_ value: @escaping () -> Bool) -> some View {
        hidden(value())
    }
}
