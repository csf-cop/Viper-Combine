//
//  FilmRequest.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Combine

struct FilmRequest: APIRequestCombine {
    typealias CodableType = FilmCollections
    static var pathParams: [String] = []
    static var method: Api.HTTPMethod = .get
    static var endpoint: Api.Endpoint = .fetFilms
    static var isEnableLog: Bool = true
}

struct FilmRequestOriginal: APIRequestOriginal {
    typealias CodableType = FilmCollections
    static var pathParams: [String] = []
    static var method: Api.HTTPMethod = .get
    static var endpoint: Api.Endpoint = .fetFilms
    static var isEnableLog: Bool = true
}
