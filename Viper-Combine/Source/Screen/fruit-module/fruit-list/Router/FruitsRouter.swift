//
//  FruitsRouter.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

#warning("Fruit router.")
class FruitsRouter: FruitsRouterProtocol, ObservableObject {
    func pushToFruitDetail(with fruit: Fruit,from view: UIViewController) {
        let fruitDetailViewController: FruitDetailViewController = FruitDetailViewController()
        FruitDetailRouter.createFruitDetailModule(with: fruitDetailViewController, and: fruit)
        view.navigationController?.pushViewController(fruitDetailViewController, animated: true)
    }

    class func createFruitListModule(fruitListRef: FruitsViewController) {
        let presenter: FruitsPresenterProtocol & FruitsOutputInteractorProtocol = FruitsPresenter()
        fruitListRef.presenter = presenter
        fruitListRef.presenter?.router = FruitsRouter()
        fruitListRef.presenter?.view = fruitListRef
        fruitListRef.presenter?.interactor = FruitsInteractor()
        fruitListRef.presenter?.interactor?.presenter = presenter
    }
}
