//
//  APIRequestRepresentableOriginal.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Alamofire
import Combine

protocol APIRequestRepresentableOriginal {
    static var endpoint: Api.Endpoint { get set }
    static var url: String { get }

    static func request(parameters: [String: Any]?) -> AnyPublisher<FilmCollections, ApiError>
}

extension APIRequestRepresentableOriginal {
    static var url: String {
        return Api.generateUrl(endpoint: endpoint)
    }

    static func request(parameters: [String: Any]?) -> AnyPublisher<FilmCollections, ApiError> {
        return URLSession.shared
        .dataTaskPublisher(for: URL(string: url)!)
        .subscribe(on: DispatchQueue(label: "API", qos: .default, attributes: .concurrent))
        .tryMap { output in
            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
              throw ApiError.invalidResponse
            }
            return output.data
        }
        .mapError { error -> ApiError in
              switch error {
              case is URLError:
                return .errorURL
              case is DecodingError:
                return .errorParsing
              default:
                return error as? ApiError ?? .unknown
              }
            }
        .eraseToAnyPublisher()
    }
//    static func request(parameters: [String: Any]? = nil,
//                        callback: @escaping (Result<CodableType>) -> Void) -> DataRequest? {
//        #if os(iOS)
//        guard Network.shared.isReachable else {
//            callback(.error(.lostNetwork))
//            return nil
//        }
//        #endif
//
//        var parameters: [String: Any] = commonParameters
//        parameters.updateValues(parameters)
//        if isEnableLog {
//            logRequest(data: parameters)
//        }
//
//        var encodingType: ParameterEncoding = JSONEncoding.default
//        if method == .get {
//            parameters = [:]
//            encodingType = URLEncoding.default
//        }
//
//        let queue: DispatchQueue = DispatchQueue(label: App.bundleID + UUID().uuidString,
//                                                 qos: .userInitiated,
//                                                 attributes: .concurrent,
//                                                 autoreleaseFrequency: .inherit,
//                                                 target: nil)
//
//        return AF.request(url,
//                          method: method,
//                          parameters: parameters,
//                          encoding: encodingType,
//                          headers: defaultHeader)..responseJSON(queue: queue,
//                                                               options: .allowFragments,
//            completionHandler: handleCompletion(callback)).
//    }
}

