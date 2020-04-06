//
//  FilmProvider.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Combine

final class FilmProvider {
//    @discardableResult
    func fetchFilms() -> AnyPublisher<FilmCollections, ApiError> {
        return FilmRequest.request(parameters: [:])
    }

    func fetchFilmsOriginal(completion: @escaping (Data?, ApiError?) -> Void) {
        return FilmRequestOriginal.request(completion: completion)
    }
}
