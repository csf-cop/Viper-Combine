//
//  Device.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

struct Device {
    static var uuid: String {
        let uuidInUserDefault = SecurePreference.shared.string(forKey: SaveKey.uuid)
        let uuidInKeyChain = SecurePreference.shared.stringInSecure(forKey: SaveKey.uuidInKeyChain)

        if uuidInUserDefault.isEmpty && uuidInKeyChain.isEmpty {
            let newUUID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            SecurePreference.shared.setToSecure(newUUID, forKey: SaveKey.uuidInKeyChain)
            SecurePreference.shared.set(newUUID, forKey: SaveKey.uuid)
        } else if !uuidInUserDefault.isEmpty && uuidInUserDefault != uuidInKeyChain {
            SecurePreference.shared.setToSecure(uuidInUserDefault, forKey: SaveKey.uuidInKeyChain)
        }

        return SecurePreference.shared.stringInSecure(forKey: SaveKey.uuidInKeyChain)
    }

    static var phoneOS: String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }

    static var modelName: String {
        return UIDevice.modelName
    }

    static var OS: String {
        return "ios"
    }
}

extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String {
            switch identifier {
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
        }

        return mapToDevice(identifier: identifier)
    }()
}
