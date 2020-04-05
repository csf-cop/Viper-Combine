//
//  APIRequestRepresentableOriginal.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Alamofire

protocol APIRequestRepresentableOriginal: APIRequestRepresentable {
    static func request(parameters: [String: Any]?, callback: @escaping (Result<CodableType>) -> Void) -> DataRequest?
}

extension APIRequestRepresentableOriginal {
    static func request(parameters: [String: Any]? = nil,
                        callback: @escaping (Result<CodableType>) -> Void) -> DataRequest? {
        #if os(iOS)
        guard Network.shared.isReachable else {
            callback(.error(.lostNetwork))
            return nil
        }
        #endif

        var parameters: [String: Any] = commonParameters
        parameters.updateValues(parameters)
        if isEnableLog {
            logRequest(data: parameters)
        }

        var encodingType: ParameterEncoding = JSONEncoding.default
        if method == .get {
            parameters = [:]
            encodingType = URLEncoding.default
        }

        let queue: DispatchQueue = DispatchQueue(label: App.bundleID + UUID().uuidString,
                                                 qos: .userInitiated,
                                                 attributes: .concurrent,
                                                 autoreleaseFrequency: .inherit,
                                                 target: nil)

        return AF.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: encodingType,
                          headers: defaultHeader).responseJSON(queue: queue,
                                                               options: .allowFragments,
                                                               completionHandler: handleCompletion(callback))
    }

    private static func handleCompletion(_ callback: @escaping (Result<CodableType>) -> Void) -> ((AFDataResponse<Any>) -> Void) {
        return { responseData in
            if isEnableLog {
                logResponse(data: responseData)
            }

            if let error: Error = responseData.error {
                DispatchQueue.main.async {
                    callback(.error(.serverError(error)))
                }
                return
            }

            guard let response: HTTPURLResponse = responseData.response else {
                let err: NSError = NSError(domain: url, code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    callback(.error(.noResponse(err)))
                }
                return
            }

            let statusCode: Int = response.statusCode
            guard let data: Data = responseData.data else {
                let err: NSError = NSError(domain: url, code: statusCode, userInfo: nil)
                DispatchQueue.main.async {
                    callback(.error(.emptyData(err)))
                }
                return
            }
            if let decoded: CodableType = try? JSONDecoder().decode(CodableType.self, from: data) {
                DispatchQueue.main.async {
                    callback(.success(decoded))
                }
                return
            } else {
                DispatchQueue.main.async {
                    callback(.error(.missingData))
                }
            }
        }
    }
}

