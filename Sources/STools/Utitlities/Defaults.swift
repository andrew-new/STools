//
//  File.swift
//  
//
//  Created by Joe Maghzal on 29/05/2023.
//

import SwiftUI

@available(iOS 14.0, macOS 12.0, *)
@propertyWrapper public struct Defaults<Value: Codable>: DynamicProperty {
    @AppStorage("") private var defaultsData: Data?
    public let key: String
    public let defaultValue: Value
    public let storage: UserDefaults
    public init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults) {
        self._defaultsData = AppStorage(key, store: storage)
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    public var wrappedValue: Value {
        get {
            guard let data = defaultsData else {
                return defaultValue
            }
            if let dataValue = data as? Value {
                return dataValue
            }
            return (try? JSONDecoder().decode(Value.self, from: data)) ?? defaultValue
        }
        nonmutating set {
            if let oldData = storage.data(forKey: key) {
                storage.set(oldData, forKey: key + "Old")
            }
            if let dataValue = newValue as? Data {
                defaultsData = dataValue
            }else {
                guard let data = try? JSONEncoder().encode(newValue) else {return}
                defaultsData = data
            }
        }
    }
    public var oldValue: Value {
        get {
            guard let data = storage.data(forKey: key + "Old") else {
                return defaultValue
            }
            if let dataValue = data as? Value {
                return dataValue
            }
            return (try? JSONDecoder().decode(Value.self, from: data)) ?? defaultValue
        }
    }
    public var projectedValue: Binding<Value> {
        return Binding {
            return wrappedValue
        } set: { newValue, _ in
            wrappedValue = newValue
        }
    }
}
