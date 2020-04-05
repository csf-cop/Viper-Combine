//
//  APIRequestRepresentable.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

typealias GPResult<T: Codable> = (Result<GPResponse<T>>) -> Void

protocol APIRequestRepresentable {
    associatedtype CodableType: Codable
    static var method: Alamofire.HTTPMethod { get set }
    static var endpoint: Api.Endpoint { get set }
    static var url: String { get }
    static var commonParameters: [String: Any] { get }
    static func request(parameters: [String: Any]?, callback: @escaping (GPResult<CodableType>)) -> DataRequest?
    static var defaultHeader: HTTPHeaders { get }
    static var isEnableLog: Bool { get }
}

extension APIRequestRepresentable {
    static var defaultHeader: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }

    static var url: String {
        return Api.generateUrl(endpoint: endpoint)
    }

    static var commonParameters: [String: Any] {
        #if os(iOS)
        return ["os": Device.OS, "uuid": Device.uuid, "token": App.token]
        #endif
    }

    static var isEnableLog: Bool {
        return false
    }

    static func logResponse(data: AFDataResponse<Any>) {
        if let mode = App.Mode(rawValue: Environment.mode), mode == .debug {
            print("RESPONSE DATA:")
            print("--\(String(describing: data.request?.url?.absoluteString))")
            print("--\(String(describing: data.result))")
            print("--\(String(describing: data.error)) \n")
        }
    }

    static func logRequest(data: [String: Any]) {
        if let mode = App.Mode(rawValue: Environment.mode), mode == .debug {
            print("REQUEST DATA:")
            print("\(data)\n")
        }
    }

    static func request(parameters: [String: Any]? = nil, callback: @escaping (Result<GPResponse<CodableType>>) -> Void) -> DataRequest? {
        #if os(iOS)
        guard Network.shared.isReachable else {
            callback(.error(.lostNetwork))
            return nil
        }
        #endif

        var paraUpdate: [String: Any] = commonParameters
        paraUpdate.updateValues(parameters)
        if isEnableLog {
            logRequest(data: paraUpdate)
        }

        var encodingType: ParameterEncoding = JSONEncoding.default
        if method == .get {
            paraUpdate = [:]
            encodingType = URLEncoding.default
        }

        let queue: DispatchQueue = DispatchQueue(label: App.bundleID + UUID().uuidString,
                                                 qos: .userInitiated,
                                                 attributes: .concurrent,
                                                 autoreleaseFrequency: .inherit,
                                                 target: nil)
        return AF.request(url,
                          method: method,
                          parameters: paraUpdate,
                          encoding: encodingType,
                          headers: defaultHeader).responseJSON(queue: queue,
                                                               options: .allowFragments,
                                                               completionHandler: handleCompletion(callback))}

    private static func handleCompletion(_ callback: @escaping GPResult<CodableType>) -> ((AFDataResponse<Any>) -> Void) {
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
            guard let data = responseData.data else {
                let err: NSError = NSError(domain: url, code: statusCode, userInfo: nil)
                DispatchQueue.main.async {
                    callback(.error(.emptyData(err)))
                }
                return
            }
            if let decoded: GPResponse = try? JSONDecoder().decode(GPResponse<CodableType>.self, from: data) {
                if let msg: String = decoded.error {
                    let err: NSError = NSError(domain: url, code: statusCode, message: msg)
                    DispatchQueue.main.async {
                        callback(.error(.serverError(err)))
                    }
                } else {
                    DispatchQueue.main.async {
                        callback(.success(decoded))
                    }
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

extension Dictionary {
    public var allKeys: [Key] {
        return Array(keys)
    }

    public var allValues: [Value] {
        return Array(values)
    }

    mutating func updateValues(_ info: [Key: Value]?) {
        guard let info = info else { return }
        for (key, value) in info {
            self[key] = value
        }
    }
}
