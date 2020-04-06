//
//  APIRequestOriginal.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

protocol APIRequestOriginal: APIRequest {
    static func request(parameters: [String: Any]?, completion: @escaping (Data?, ApiError?) -> Void)
}

extension APIRequestOriginal {
    static func request(parameters: [String: Any]? = nil, completion: @escaping (Data?, ApiError?) -> Void) {
        var urlRequest: URLRequest = URLRequest(url: URL(string: Api.generateUrl(endpoint: endpoint, params: pathParams))!)
        urlRequest.httpMethod = method.string

        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, ApiError.error(error.localizedDescription))
                } else {
                    if let data = data {
                        let json: JSON = data.toJSON()
                        print("Json data: \(json)")
                        completion(data, nil)
                    } else {
                       completion(nil, ApiError.error("Data format is error."))
                    }
                }
            }
        }
        task.resume()
    }
}
