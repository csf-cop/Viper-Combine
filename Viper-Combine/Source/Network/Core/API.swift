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

    enum HTTPMethod: String {
        case get
        case post
        case push
        case delete
        case option
        case patch

        var string: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .push:
                return "PUSH"
            case .delete:
                return "DELETE"
            case .option:
                return "OPTION"
            case .patch:
                return "PATCH"
            }
        }
    }

    static let baseUrl: String = Environment.baseUrl

    enum Endpoint {
        case fetFilms

        var string: String {
            switch self {
            case .fetFilms:
                return "/api/films/"
            }
        }
    }

    static func generateUrl(endpoint: Endpoint, params: [String]) -> String {
        var path: String = ""
        for param in params {
            path += "/\(param)"
        }
        return "\(Api.baseUrl)\(endpoint.string)\(path)"
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
