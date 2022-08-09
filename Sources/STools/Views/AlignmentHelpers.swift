//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

public extension View {
///STools: Adjust this view's frame with a fallback frame.
    @ViewBuilder func framey(width: CGFloat, height: CGFloat, masterWidth: CGFloat? = nil, masterHeight: CGFloat? = nil, master: Bool) -> some View {
        self
            .frame(width: master ? (masterWidth ?? width): width, height:  master ? (masterHeight ?? height): height)
    }
///STools: Pin this view to an Edge.
    @ViewBuilder func pin(to edge: ViewEdge) -> some View {
        switch edge {
            case .top:
                VStack {
                    self
                    Spacer()
                }
            case .leading:
                HStack {
                    self
                    Spacer()
                }
            case .bottom:
                VStack {
                    Spacer()
                    self
                }
            case .trailing:
                HStack {
                    Spacer()
                    self
                }
            case .horizontal:
                HStack {
                    Spacer()
                    self
                    Spacer()
                }
            case .vertical:
                VStack {
                    Spacer()
                    self
                    Spacer()
                }
        }
    }
///STools: Pin this view relative to another.
    @ViewBuilder func alignment<Content: View>(with view: @escaping () -> Content, pinned edge: Edge, spacing: CGFloat? = nil) -> some View {
        self
            .alignment(with: view(), pinned: edge, spacing: spacing)
    }
///STools: Pin this view relative to another.
    @ViewBuilder func alignment<Content: View>(with view: Content, pinned edge: Edge, spacing: CGFloat? = nil) -> some View {
        switch edge {
            case .top:
                VStack(spacing: spacing) {
                    view
                    self
                }
            case .leading:
                HStack(spacing: spacing) {
                    view
                    self
                }
            case .bottom:
                VStack(spacing: spacing) {
                    self
                    view
                }
            case .trailing:
                HStack(spacing: spacing) {
                    self
                    view
                }
        }
    }
}
