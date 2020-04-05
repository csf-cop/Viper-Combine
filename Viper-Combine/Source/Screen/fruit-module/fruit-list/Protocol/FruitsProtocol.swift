//
//  FruitsProtocol.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

protocol FruitsViewProtocol: class {
    // PRESENTER -> VIEW
    func showFruits(with fruits: [Fruit])
}

protocol FruitsPresenterProtocol: class {
    //View -> Presenter
    var interactor: FruitsInputInteractorProtocol? { get set }
    var view: FruitsViewProtocol? { get set }
    var router: FruitsRouterProtocol? { get set }

    func fetFruits()
    func showFruitSelection(with fruit: Fruit, from view: UIViewController)
}

protocol FruitsInputInteractorProtocol: class {
    var presenter: FruitsOutputInteractorProtocol? { get set }
    //Presenter -> Interactor
    func getFruitList()
}

protocol FruitsOutputInteractorProtocol: class {
    //Interactor -> Presenter
    func fruitListDidFetch(fruitList: [Fruit])
}

protocol FruitsRouterProtocol: class {
    //Presenter -> Router
    func pushToFruitDetail(with fruit: Fruit, from view: UIViewController)
    static func createFruitListModule(fruitListRef: FruitsViewController)
}
