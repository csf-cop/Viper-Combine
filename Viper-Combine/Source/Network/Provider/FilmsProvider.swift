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
#endif

final class FilmsProvider {

    @discardableResult
    func fetchFilms(isUseStub: Bool = false, callback: @escaping (Result<Films>) -> Void) -> DataRequest? {
        #if os(iOS)
        if isUseStub {
            stub(condition: isHost("swapi.co")) { _ in
              // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
              let stubPath = OHPathForFile("FilmResponse", type(of: self))
              return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
            }
        }
        #endif
//        return FetchFilmsRequest.request(callback: callback)
        return nil
    }
}
