//
//  SecurePreference.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import KeychainAccess
import CommonCrypto

class SecurePreference {
    static let shared = SecurePreference()

    private let userDefaults = UserDefaults.standard
    private let keychain = Keychain()

    // MARK: - common

    func clear() {
        guard let bundleID = Bundle.main.bundleIdentifier else { fatalError() }
        userDefaults.removePersistentDomain(forName: bundleID)
        try? keychain.removeAll()
    }

    // MARK: - UserDefaults
    func contains<Key: RawRepresentable>(forKey key: Key) -> Bool where Key.RawValue == String {
        return userDefaults.object(forKey: key.rawValue) != nil
    }

    func remove<Key: RawRepresentable>(forKey key: Key) where Key.RawValue == String {
        userDefaults.removeObject(forKey: key.rawValue)
    }

    func set<Key: RawRepresentable>(_ value: String, forKey key: Key) where Key.RawValue == String {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func set<Key: RawRepresentable>(_ value: Int, forKey key: Key) where Key.RawValue == String {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func set<Key: RawRepresentable>(_ value: Bool, forKey key: Key) where Key.RawValue == String {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func set<Key: RawRepresentable>(_ value: [String: String], forKey key: Key) where Key.RawValue == String {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func dictionary<Key: RawRepresentable>(forKey key: Key, defaultValue: [String: String] = [:])
        -> [String: String] where Key.RawValue == String {
            guard let value = userDefaults.object(forKey: key.rawValue) else { return defaultValue }
            return value as? [String: String] ?? defaultValue
    }

    func string<Key: RawRepresentable>(forKey key: Key, defaultValue: String = "")
        -> String where Key.RawValue == String {
            return userDefaults.string(forKey: key.rawValue) ?? defaultValue
    }

    func integer<Key: RawRepresentable>(forKey key: Key, defaultValue: Int = 0)
        -> Int where Key.RawValue == String {
            guard let value = userDefaults.object(forKey: key.rawValue) else { return defaultValue }
            return (value as? Int) ?? defaultValue
    }

    func bool<Key: RawRepresentable>(forKey key: Key, defaultValue: Bool = false)
        -> Bool where Key.RawValue == String {
            guard let value = userDefaults.object(forKey: key.rawValue) else { return defaultValue }
            return (value as? Bool) ?? defaultValue
    }

    // MARK: - Keychain
    func containsInSecure<Key: RawRepresentable>(forKey key: Key) -> Bool where Key.RawValue == String {
        return (try? keychain.contains(key.rawValue)) ?? false
    }

    func removeFromSecure<Key: RawRepresentable>(forKey key: Key) where Key.RawValue == String {
        try? keychain.remove(key.rawValue)
    }

    func removeAllFromSecure() {
        try? keychain.removeAll()
    }

    func setToSecure<Key: RawRepresentable>(_ value: String, forKey key: Key) where Key.RawValue == String {
        try? keychain.set(value, key: key.rawValue)
    }

    func stringInSecure<Key: RawRepresentable>(forKey key: Key, defaultValue: String = "")
        -> String where Key.RawValue == String {
            return keychain[key.rawValue] ?? defaultValue
    }

    func setToSecure<Key: RawRepresentable>(_ value: Int, forKey key: Key)
    where Key.RawValue == String {
        setToSecure(String(value), forKey: key)
    }

    func intInSecure<Key: RawRepresentable>(forKey key: Key, defaultValue: Int = 0)
        -> Int where Key.RawValue == String {
            guard let data = keychain[key.rawValue] else { return defaultValue }
            return Int(data) ?? defaultValue
    }

    func setToSecure<Key: RawRepresentable>(_ value: Bool, forKey key: Key)
    where Key.RawValue == String {
        setToSecure(String(value), forKey: key)
    }

    func boolInSecure<Key: RawRepresentable>(forKey key: Key, defaultValue: Bool = false)
        -> Bool where Key.RawValue == String {
            guard let data = keychain[key.rawValue] else { return defaultValue }
            return Bool(data) ?? defaultValue
    }
}
