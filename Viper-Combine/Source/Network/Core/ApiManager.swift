//
//  ApiManager.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

// MARK: Interact with Resful
typealias Completion<Value> = (Result<Value>) -> Void
typealias APICompletion = (ApiResult) -> Void

let api = ApiManager()

enum ApiResult {
    case success
    case failure(Error)
}

final class ApiManager {
    var defaultHTTPHeaders: [String: Any] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
}

// MARK: - Equatable
extension ApiResult: Equatable {
    public static func == (lhs: ApiResult, rhs: ApiResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - Get error for api result
extension ApiResult {
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
