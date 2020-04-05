//
//  FilmsProvider.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire
#if os(iOS)
import OHHTTPStubs
import Combine
#endif

final class FilmsProvider {

//    @discardableResult
//    func fetchFilms(isUseStub: Bool = false, callback: @escaping (Result<FilmCollections>) -> Void) -> AnyPublisher<FilmCollections, ApiError> {
//        #if os(iOS)
//        if isUseStub {
//            stub(condition: isHost(Environment.host)) { _ in
//              // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
//                let stubPath: String? = OHPathForFile("FilmResponse", type(of: self))
//              return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
//            }
//        }
//        #endif
//        return FetchFilmsRequest.request(parameters: nil)
//    }
}
