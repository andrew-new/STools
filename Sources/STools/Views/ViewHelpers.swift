//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

extension View {
///STools: Set  this view's foreground content.
    @ViewBuilder func foreground<Content: View>(_ view: Content) -> some View {
        self
            .overlay(view)
            .mask(self)
    }
///STools: Set  this view's foreground content.
    @ViewBuilder func foreground<Content: View>(@ViewBuilder view: @escaping () -> Content) -> some View {
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

