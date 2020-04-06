//
//  APIRequestCombine.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Combine

protocol APIRequestCombine: APIRequest {
    static func request(parameters: [String: Any]?) -> AnyPublisher<CodableType, ApiError>
}

extension APIRequestCombine {
    static func request(parameters: [String: Any]?) -> AnyPublisher<CodableType, ApiError> {
        switch method {
        case .get:
            return fetchData(parameters: parameters)
        case .post:
            print("POST method")
            break
        case .push:
            print("PUSH method")
            break
        case .delete:
            print("DELETE method")
            break
        case .option:
            print("OPTION method")
            break
        case .patch:
            print("PATCH method")
            break
        }
        return fetchData(parameters: parameters)
    }

    static private func fetchData(parameters: [String: Any]?) -> AnyPublisher<CodableType, ApiError> {
        let decoder = JSONDecoder()
        let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)

        // MARK: Write log detail.
        if isEnableLog {
            if let mode = App.Mode(rawValue: Environment.mode), mode == .debug {
                print("REQUEST DATA:")
                print("\(commonParameters)\n")
            }
        }

        var urlRequest: URLRequest = URLRequest(url: URL(string: Api.generateUrl(endpoint: endpoint, params: pathParams))!)
        urlRequest.httpMethod = method.string

        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: apiQueue)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            return output.data
        }
        .decode(type: CodableType.self, decoder: decoder)
        .mapError { error -> ApiError in
            switch error {
            case is URLError:
              return .errorURL
            case is DecodingError:
              return .errorParsing
            default:
                return (error as? ApiError).unwrapped(or: .unknown)
            }
        }
        .eraseToAnyPublisher()
    }
}
