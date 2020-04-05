//
//  Environment.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum Environment {
    static let baseURL: String = "swapi.co"
    static let watchMode: App.Mode = .debug

    enum Keys {
        static let baseURL = "GP_BASE_URL"
        static let mode = "GP_MODE"
        static let baseURLWebView = "GP_BASE_URL_WEB_VIEW"
        static let appVersion = "GP_APP_VERSION"
        static let googleMapKey = "GG_MAP_KEY"
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict: [String: Any] = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let host: String = {
        #if os(watchOS)
        return baseURL
        #elseif os(iOS)
        guard let host: String = Environment.infoDictionary[Keys.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
        #endif
    }()

    static let hostWebView: String = {
        guard let host: String = Environment.infoDictionary[Keys.baseURLWebView] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return host
    }()

    // MARK: - Plist values
    static let baseUrl: String = {
        return "https://\(Environment.host)"
    }()

    static let baseUrlWebView: String = {
        return "https://\(Environment.hostWebView)"
    }()

    static let mode: String = {
        #if os(watchOS)
        return watchMode.rawValue
        #elseif os(iOS)
        guard let mode: String = Environment.infoDictionary[Keys.mode] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return mode
        #endif
    }()

    static let appVersion: String = {
        guard let version: String = Environment.infoDictionary[Keys.appVersion] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return version
    }()

    static let googleMapKey: String = {
        guard let key: String = Environment.infoDictionary[Keys.googleMapKey] as? String else {
            fatalError("Mode Key not set in plist for this environment")
        }
        return key
    }()
}
