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
class FruitsInteractor: FruitsInputInteractorProtocol, ObservableObject {
    weak var presenter: FruitsOutputInteractorProtocol?
    @Published var fruitList: [Fruit] = [Fruit]()

    func getFruitList() {
        presenter?.fruitListDidFetch(fruitList: getAllFruitDetail())
    }

    // MARK: Call API fetch film (cause have no Fruit API)
    func getAllFruitDetail() -> [Fruit] {
        let provider: FilmsProvider = FilmsProvider()
        provider.fetchFilms { [] result in
            switch result {
            case .success(let value):
                guard let data: FilmCollections = value else {
                    print("Cast fail.")
                    return
                }
                print("data: \(data)")
                data.all.forEach { film in
                    let item: [String: String] = ["name": film.title,"vitamin": film.producer]
                    self.fruitList.append(Fruit(attributes: item))
                }
                #warning("Still not receive data. Because response time delay.")
            case .error(let e):
                print("Error happen: \(e.localizedDescription)")
            }
        }

        let allFruitDetail: [[String: String]] = [["name": "Watermelon","vitamin": "Vitain A"], ["name": "Banana","vitamin": "Vitain B6"], ["name": "Apple","vitamin": "Vitain C"]]

        for item in allFruitDetail {
            fruitList.append(Fruit(attributes: item))
        }
        return fruitList
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
