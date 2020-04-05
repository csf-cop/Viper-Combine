//
//  FruitsInteractor.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire
import Combine

#warning("Fruit List module’s business logic and handlings.")
class FruitsInteractor: FruitsInputInteractorProtocol, ObservableObject {
    weak var presenter: FruitsOutputInteractorProtocol?
    private var subscriptions = Set<AnyCancellable>()
    private var api = APIFilm()
    private var fruitList: [Fruit] = [Fruit]() {
        didSet {
            presenter?.fruitListDidFetch(fruitList: fruitList)
        }
    }

    func getFruitList() {
        presenter?.fruitListDidFetch(fruitList: getAllFruitDetail())
    }

    // MARK: Call API fetch film (cause have no Fruit API)
    private func getAllFruitDetail() -> [Fruit] {
        api.fetchFilms()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }) { apiResult in
                apiResult.all.forEach { film in
                    let item: [String: String] = ["name": film.title,"vitamin": film.producer]
                    self.fruitList.append(Fruit(attributes: item))
                }
        }.store(in: &subscriptions)
        return fruitList
    }
}
