//
//  HTTPStatus.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

public enum HTTPStatus: Int {
    case unknown = -1
    case uuidError, tokenError = 403

    public init?(code: Int) {
        self.init(rawValue: code)
    }

    public var code: Int {
        return rawValue
    }
}

extension HTTPStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .uuidError, .tokenError:
            return ""
        default:
            return "Unknown message"
        }
    }
}
