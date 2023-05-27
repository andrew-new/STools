//
//  SwipeActionsViewModifer.swift
//  
//
//  Created by Joe Maghzal on 27/05/2023.
//

import SwiftUI

public struct SwipeActionsViewModifer: ViewModifier {
//MARK: - Properties
    @State private var trailingExpanded = false
    @State private var leadingExpanded = false
    @State private var trailingPadding = CGFloat.zero
    @State private var leadingPadding = CGFloat.zero
    @State private var gesturePaused = false
    internal var enabled: Bool
    internal var actions: [SwipeAction]
//MARK: - Mappings
    private var trailingButtonWidth: CGFloat {
        let difference = trailingPadding - 80
        return difference > 0 ? difference: 0
    }
    private var leadingButtonWidth: CGFloat {
        let difference = leadingPadding - 80
        return difference > 0 ? difference: 0
    }
//MARK: - Body
    public func body(content: Content) -> some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(actions.filter({$0.isLeading})) { item in
                    item.content
                        .buttonStyle(.plain)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .frame(width: 100 + leadingButtonWidth, height: item.height)
                        .background(item.tint)
                        .clipShape(RoundedRectangle(cornerRadius: item.radius))
                        .padding(.leading, -100 + leadingPadding - leadingButtonWidth)
                }
                Spacer()
                ForEach(actions.filter({!$0.isLeading})) { item in
                    item.content
                        .buttonStyle(.plain)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                        .frame(width: 100 + trailingButtonWidth, height: item.height)
                        .background(item.tint)
                        .clipShape(RoundedRectangle(cornerRadius: item.radius))
                        .padding(.trailing, -100 + trailingPadding - trailingButtonWidth)
                }
            }.hidden(!enabled)
            content
                .padding(.leading, -trailingPadding)
                .padding(.trailing, -leadingPadding)
                .highPriorityGesture(gesture).padding(.trailing, trailingPadding)
                .padding(.leading, leadingPadding)
                .change(of: enabled) { newValue in
                    trailingPadding = newValue ? trailingPadding: 0
                    leadingPadding = newValue ? leadingPadding: 0
                }
        }
    }
    var gesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onChanged { newValue in
                guard !gesturePaused && enabled else {return}
                let newPadding = abs(newValue.translation.width)
                let isSwipingFromTrailing = newValue.translation.width < 0
                if isSwipingFromTrailing {
                    guard leadingPadding == 0 else {
                        withAnimation(.spring()) {
                            leadingPadding = 0
                        }
                        gesturePaused = true
                        return
                    }
                    trailingPadding = trailingExpanded ? 80 + newPadding: newPadding
                }else {
                    guard trailingPadding == 0 else {
                        withAnimation(.spring()) {
                            trailingPadding = 0
                        }
                        gesturePaused = true
                        return
                    }
                    leadingPadding = leadingExpanded ? 80 + newPadding: newPadding
                }
            }.onEnded { value in
                withAnimation(.spring()) {
                    guard !gesturePaused && enabled else {
                        gesturePaused = false
                        return
                    }
                    trailingPadding = value.translation.width < 0 ? 80: 0
                    leadingPadding = value.translation.width > 0 ? 80: 0
                    trailingExpanded = trailingPadding > 0
                    leadingExpanded = leadingPadding > 0
                }
            }
    }
}

//MARK: - Modifiers
public extension View {
    func swipeActions(enabled: Bool = true, @SwipeActionsResultBuilder actions: () -> [SwipeAction]) -> some View {
        modifier(SwipeActionsViewModifer(enabled: enabled, actions: actions()))
    }
    func swipeContent(edge: SwipeEdge) -> SwipeAction {
        return SwipeAction(content: AnyView(self), isLeading: edge == .leading, tint: .gray)
    }
}
