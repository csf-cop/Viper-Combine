//
//  APIError.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case notReachable
    case notFound
    case missingData
    case emptyData(Error)
    case lostNetwork
    case noResponse(Error?)
    case serverError(Error)
    case error(String)
    case errorURL
    case invalidResponse
    case errorParsing
    case unknown

    var message: String {
        switch self {
        case .notReachable:
            return "Not Reachable"
        case .notFound:
            return "Not Found"
        case .lostNetwork:
            return "Lost Network"
        case .emptyData:
            return getMessageError()
        case .noResponse:
            return getMessageError()
        case .missingData:
            return "Missing Data"
        case .serverError:
            return getMessageError()
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        case .invalidResponse:
            return "Invalid response"
        case .errorParsing:
            return "Failed parsing response from server"
        case .unknown:
            return "An unknown error occurred"
        }
    }

    var nsError: NSError? {
        switch self {
        case .emptyData(let e):
            return (e as NSError?)
        case .noResponse(let e):
            return (e as NSError?)
        case .serverError(let e):
            return (e as NSError?)
        default:
            return nil
        }
    }

    var httpStatus: HTTPStatus? {
        switch self {
        case .emptyData(let e):
            return makeHTTPStatus(from: e)
        case .noResponse(let e):
            return makeHTTPStatus(from: e)
        case .serverError(let e):
            return makeHTTPStatus(from: e)
        default:
            return nil
        }
    }

    private func getMessageError() -> String {
        if let httpMessage = httpStatus?.description, !httpMessage.isEmpty {
            return httpMessage
        }
        return (nsError?.localizedDescription).unwrapped(or: "")
    }

    private func makeHTTPStatus(from e: Error?) -> HTTPStatus? {
        let nsError = (e as NSError?)
        return nsError?.httpStatus()
    }
}

extension NSError {
    public convenience init(domain: String? = nil, status: HTTPStatus, message: String? = nil) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? status.description]
        self.init(domain: domain, code: status.code, userInfo: userInfo)
    }

    public convenience init(domain: String? = nil, code: Int = -999, message: String) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message]

        self.init(domain: domain, code: code, userInfo: userInfo)
    }

    func httpStatus() -> HTTPStatus? {
        return HTTPStatus(rawValue: code)
    }
}

extension Error {
    func show() {
        let `self` = self as NSError
        self.show()
    }

    public var code: Int {
        let `self` = self as NSError
        return self.code
    }
}

extension NSError {
    func show() { }
}
