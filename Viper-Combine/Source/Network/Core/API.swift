//
//  API.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

#if os(iOS)
    typealias Network = NetworkReachabilityManager

// MARK: - Network
    extension Network {
        static let shared: Network = {
            guard let manager = Network() else {
                fatalError("Cannot alloc network reachability manager!")
            }
            return manager
        }()
    }
#endif

final class Api {
    static let baseUrl: String = Environment.baseUrl
    static let otherBaseUrl: String = Environment.baseUrl

    enum Endpoint {
        case fetFilms

        var string: String {
            switch self {
            case .fetFilms:
                return "/api_base/"
            }
        }
    }

    static func generateUrl(endpoint: Endpoint) -> String {
        return "\(Api.baseUrl)\(endpoint.string)"
    }

    static func generateUrlWithParam(endpoint: Endpoint, params: [String]) -> String {
        var path: String = ""
        for param in params {
            path += "/\(param)"
        }
        return "\(Api.otherBaseUrl)\(endpoint.string)\(path)"
    }
}

enum Result<T> {
    case success(T)
    case error(ApiError)

    var error: ApiError? {
        switch self {
        case .error(let e):
            return e
        default:
            return nil
        }
    }

    var value: T? {
        switch self {
        case .success(let a):
            return a
        default:
            return nil
        }
    }
}

struct EmptyData: Codable { }
