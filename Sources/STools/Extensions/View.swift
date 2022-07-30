//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension View {
    var unImage: UNImage {
#if canImport(UIKit)
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        let image = controller.view.uiImage
        controller.view.removeFromSuperview()
        return image
#elseif canImport(AppKit)
        let view = NoInsetHostingView(rootView: self)
        view.setFrameSize(view.fittingSize)
        return view.bitmapImage() ?? NSImage()
#endif
    }
    var unView: UNView {
#if canImport(UIKit)
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        return controller.view
#elseif canImport(AppKit)
        let view = NoInsetHostingView(rootView: self)
        view.setFrameSize(view.fittingSize)
        return view
#endif
    }
    func foreground<Content: View>(_ view: Content) -> some View {
        self.overlay(view).mask(self)
    }
    func foreground<Content: View>(@ViewBuilder view: @escaping () -> Content) -> some View {
        self.overlay(view()).mask(self)
    }
    @ViewBuilder func onTask<ID: Equatable>(id: ID? = nil, priority: _Concurrency.TaskPriority? = nil, _ task: @Sendable @escaping () async -> Void) -> some View {
        if #available(iOS 15.0, macOS 12.0, watchOS 8.0, *) {
            if let id = id, let priority = priority {
                self
                    .task(id: id, priority: priority, task)
            }else if let id = id{
                self
                    .task(id: id, task)
            }else if let priority = priority {
                self
                    .task(priority: priority, task)
            }else {
                self
                    .task(task)
            }
        }else {
            self
        }
    }
    @ViewBuilder func tapGesture(completion: (() -> Void)? = nil) -> some View {
        if let completion = completion {
            self
                .onTapGesture {
                    completion()
                }
        }else {
            self
        }
    }
    func framey(width: CGFloat, height: CGFloat, masterWidth: CGFloat? = nil, masterHeight: CGFloat? = nil, master: Bool) -> some View {
        if master {
            return self
                .frame(width: masterWidth ?? width, height: masterHeight ?? height)
        }
        return self
            .frame(width: width, height: height)
    }
    @ViewBuilder func change<T: Equatable>(of: T, action: @escaping (_ value: T) -> ()) -> some View {
        if #available(iOS 14.0, macOS 11.0, *) {
            self.onChange(of: of) { value in
                action(of)
            }
        }else {
            self.onReceive([of].publisher.first()) { value in
                action(of)
            }
        }
    }
}
