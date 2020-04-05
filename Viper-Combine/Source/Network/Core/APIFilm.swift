//
//  APIFilm.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Combine

struct APIFilm {
    //MARK: EndPoint
    enum EndPoint {
        static let baseURL = URL(string: Environment.baseUrl)!

        case fetchFilmCollection

        var url: URL {
            switch self {
            case .fetchFilmCollection:
                return EndPoint.baseURL.appendingPathComponent(Api.Endpoint.fetFilms.string)
            }
        }
    }
  
    // MARK: Properties
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
  
    //MARK: init
    init() { }
  
    //MARK: Public methods
    func fetchFilms() -> AnyPublisher<FilmCollections, ApiError> {
        return URLSession.shared
            .dataTaskPublisher(for: EndPoint.fetchFilmCollection.url)
            .subscribe(on: apiQueue)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            return output.data
        }
        .decode(type: FilmCollections.self, decoder: JSONDecoder())
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
}
