//
//  File.swift
//  
//
//  Created by Joe Maghzal on 8/6/22.
//

import SwiftUI

public extension View {
///STools: Listen to changes made to a property
    @ViewBuilder func onChange<T: Equatable>(_ element: T, action: @escaping (_ value: T) -> ()) -> some View {
        if #available(iOS 14.0, macOS 11.0, *) {
            self
                .onChange(of: element) { newValue in
                    action(newValue)
                }
        }else {
            onReceive([element].publisher.first()) { value in
                action(value)
            }
        }
    }
///STools: Adds an asynchronous task to perform before this view appears.
    @ViewBuilder func withTask<ID: Equatable>(id: ID? = nil, priority: _Concurrency.TaskPriority? = nil, _ task: @Sendable @escaping () async -> Void) -> some View {
        if #available(iOS 15.0, macOS 12.0, watchOS 8.0, *) {
            if let id = id, let priority = priority {
                self
                    .task(id: id, priority: priority, task)
            }else if let id = id {
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
                .onAppear {
                    Task(priority: priority) {
                        await task()
                    }
                }
        }
    }
    @ViewBuilder func withTask(priority: _Concurrency.TaskPriority? = nil, _ task: @Sendable @escaping () async -> Void) -> some View {
        if #available(iOS 15.0, macOS 12.0, watchOS 8.0, *) {
            if let priority = priority {
                self
                    .task(priority: priority, task)
            }else {
                self
                    .task(task)
            }
        }else {
            self
                .onAppear {
                    Task(priority: priority) {
                        await task()
                    }
                }
        }
    }
}

public struct LoadingView: View {
    public init() {
    }
    public var body: some View {
        if #available(iOS 14.0, macOS 11.0, *) {
            ProgressView()
        }else {
            ActivityIndicatorView()
        }
    }
}

internal struct ActivityIndicatorView {
}

#if canImport(UIKit)
extension ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        return activityIndicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}
#elseif canImport(AppKit)
extension ActivityIndicatorView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSProgressIndicator {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.style = .spinning
        return progressIndicator
    }
    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
    }
}
#endif
