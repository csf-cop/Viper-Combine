//
//  FruitsPresenter.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

#warning("Fruit List module’s communication handler, we can tease the presenter like that as it handles all the communication.")
class FruitsPresenter: FruitsPresenterProtocol {
    var router: FruitsRouterProtocol?
    weak var view: FruitsViewProtocol?
    var interactor: FruitsInputInteractorProtocol?

    func showFruitSelection(with fruit: Fruit, from view: UIViewController) {
        router?.pushToFruitDetail(with: fruit, from: view)
    }

    func viewDidLoad() {
        self.loadFruitList()
    }

    func loadFruitList() {
        interactor?.getFruitList()
    }
}

extension FruitsPresenter: FruitsOutputInteractorProtocol {
    func fruitListDidFetch(fruitList: [Fruit]) {
        view?.showFruits(with: fruitList)
    }
}
