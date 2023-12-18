//
//  UserDefault + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 12/16/23.
//

import Foundation

extension UserDefaults {
    struct Key<Value> {
        let name: String
        init(_ name: String) {
            self.name = name
        }
    }
    subscript<V: Codable>(key: Key<V>) -> V? {
        get {
            guard let data = self.data(forKey: key.name) else {
                return nil
            }
            return try? JSONDecoder().decode(V.self, from: data)
        }
        set {
            guard let value = newValue, let data = try? JSONEncoder().encode(value) else {
                self.set(nil, forKey: key.name)
                return
            }
            self.set(data, forKey: key.name)
        }
    }
    subscript(key: Key<URL>) -> URL? {
        get { return self.url(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<String>) -> String? {
        get { return self.string(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<Data>) -> Data? {
        get { return self.data(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<Bool>) -> Bool {
        get { return self.bool(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<Int>) -> Int {
        get { return self.integer(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<Float>) -> Float {
        get { return self.float(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
    subscript(key: Key<Double>) -> Double {
        get { return self.double(forKey: key.name) }
        set { self.set(newValue, forKey: key.name) }
    }
}

extension UserDefaults.Key {
    typealias Key = UserDefaults.Key
    
    static var accessToken: Key<String> { return Key<String>("accessToken") }
    static var idToken: Key<String> { return Key<String>("idToken") }
    static var loginType: Key<LoginType> { return Key<LoginType>("loginType") }
    static var userId: Key<Int> { return Key<Int>("userId") }
    static var isNotFirstUser: Key<Bool> { return Key<Bool>("isFirstUser") }
    static var isNotGuestUser: Key<Bool> { return Key<Bool>("isGuestUser") }
}
