//
//  App.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

struct App {
    enum Mode: String {
        case release
        case debug
        case staging
    }

    static var token: String {
        get {
            return SecurePreference.shared.string(forKey: SaveKey.token)
        }
        set {
            SecurePreference.shared.set(newValue, forKey: SaveKey.token)
        }
    }

    static var name: String {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else { return "" }
        return appName
    }

    static var bundleID: String {
        guard let bundleID = Bundle.main.bundleIdentifier else { return "" }
        return bundleID
    }

    static var version: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }

    static let enUSLocale = Locale(identifier: "en_US")
    static let vietNamLocale = Locale(identifier: "vi_VN")
}
