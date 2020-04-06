//
//  APIRequest.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Combine

protocol APIRequest {
    associatedtype CodableType: Codable
    static var method: Api.HTTPMethod { get set }
    static var endpoint: Api.Endpoint { get set }
    static var isEnableLog: Bool { get }
    static var commonParameters: [String: Any] { get }
    static var pathParams: [String] { get set }
}

extension APIRequest {

    static var commonParameters: [String: Any] {
        #if os(iOS)
        return App.token.isEmpty ? [:] : ["os": Device.OS, "uuid": Device.uuid, "token": App.token]
        #else
        return UserDefaults.shared.dictionary(forKey: UserDefaultKey.paraRequired).unwrapped(or: [:])
        #endif
    }
}
