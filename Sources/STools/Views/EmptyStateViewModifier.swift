//
//  EmptyStateViewModifier.swift
//  
//
//  Created by Joe Maghzal on 7/29/22.
//

import SwiftUI

internal struct EmptyStateViewModifier<PlaceHolder: View>: ViewModifier {
    @State private var showEmpty = false
    let placeHolder: PlaceHolder
    let shouldEmpty: Bool
    func body(content: Content) -> some View {
        ZStack {
            if showEmpty || shouldEmpty {
                placeHolder
            }
            content
                .background(geometryReader)
        }
    }
    var geometryReader: some View {
        GeometryReader { reader in
            let empty = reader.size == .zero
            Color.clear
                .onChange(empty) { newValue in
                    showEmpty = newValue
                }
        }
    }
}

public extension View {
///STools: Display a placeholder when this view is empty.
    func emptyState<Content: View>(_ shouldEmpty: Bool = false, @ViewBuilder content: () -> Content) -> some View {
        modifier(EmptyStateViewModifier(placeHolder: content(), shouldEmpty: shouldEmpty))
    }
}
