//
//  FruitsInteractor.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

#warning("Fruit List module’s business logic and handlings.")
class FruitsInteractor: FruitsInputInteractorProtocol {
    weak var presenter: FruitsOutputInteractorProtocol?

    func getFruitList() {
        presenter?.fruitListDidFetch(fruitList: getAllFruitDetail())
    }

    // MARK: Call API fetch film (cause have no Fruit API)
    func getAllFruitDetail() -> [Fruit] {

        callAPI()

        var fruitList: [Fruit] = [Fruit]()
        let allFruitDetail: [[String: String]] = [["name": "Orange","vitamin": "Vitain C"], ["name": "Watermelon","vitamin": "Vitain A"], ["name": "Banana","vitamin": "Vitain B6"], ["name": "Apple","vitamin": "Vitain C"]]

        for item in allFruitDetail {
            fruitList.append(Fruit(attributes: item))
        }
        return fruitList
    }

    private func callAPI(isUseStub: Bool = false) {
        let provider: FilmsProvider = FilmsProvider()
        provider.fetchFilms { [] result in
            switch result {
            case .success(let value):
                guard let data: FilmCollections = value else {
                    print("Cast fail.")
                    return
                }
                print("data: \(data)")
                print("Fetch data ok")
            case .error(let e):
                print("Error happen: \(e.localizedDescription)")
            }
        }
    }
}

extension String {
    func convertFileToData() -> Data {
        guard let path = Bundle.main.path(forResource: self, ofType: "json") else {
            fatalError("Can not convert to path for \(self).json")
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can not get data from \(self).json")
        }
        return data
    }
}
