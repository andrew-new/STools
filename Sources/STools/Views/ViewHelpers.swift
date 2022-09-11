//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

public extension View {
///STools: Set  this view's foreground content.
    @ViewBuilder func foreground<Content: ContentShape>(_ view: Content) -> some View {
    #if canImport(GroupActivities)
        if #available(iOS 15.0, macOS 12.0, *) {
            self
                .foregroundStyle(view)
        }else {
            self
        }
    #else
        self
            .overlay(view)
            .mask(self)
    #endif
    }
///STools: Set  this view's foreground content.
    @ViewBuilder func foreground<Content: ShapeStyle>(@ViewBuilder view: @escaping () -> Content) -> some View {
        self
            .foreground(view())
    }
///STools: Adds custom swipe actions to a row in a list.
    @ViewBuilder func swipeActions<Content: View>(edge: SwipeEdge, allowsFullSwipe: Bool, @ViewBuilder content: @escaping () -> Content) -> some View {
        if #available(iOS 15.0, macOS 12.0, *) {
            self
                .swipeActions(edge: edge.horizontalEdge, allowsFullSwipe: allowsFullSwipe, content: content)
        }else {
            self
        }
    }
}

