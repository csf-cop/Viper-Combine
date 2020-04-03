//
//  FruitsInteractor.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

#warning("Fruit List module’s business logic and handlings.")
class FruitsInteractor: FruitsInputInteractorProtocol {
    weak var presenter: FruitsOutputInteractorProtocol?

    func getFruitList() {
        presenter?.fruitListDidFetch(fruitList: getAllFruitDetail())
    }

    func getAllFruitDetail() -> [Fruit] {
        var fruitList: [Fruit] = [Fruit]()
        let allFruitDetail: [[String: String]] = [["name": "Orange","vitamin": "Vitain C"], ["name": "Watermelon","vitamin": "Vitain A"], ["name": "Banana","vitamin": "Vitain B6"], ["name": "Apple","vitamin": "Vitain C"]]

        for item in allFruitDetail {
            fruitList.append(Fruit(attributes: item))
        }
        return fruitList
    }
}
