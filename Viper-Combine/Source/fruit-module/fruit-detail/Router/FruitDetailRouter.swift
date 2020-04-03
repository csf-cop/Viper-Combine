//
//  FruitDetailRouter.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class FruitDetailRouter: FruitDetailRouterProtocol {
    
    class func createFruitDetailModule(with fruitDetailRef: FruitDetailViewController, and fruit: Fruit) {
        let presenter = FruitDetailPresenter()
        presenter.fruit = fruit
        fruitDetailRef.presenter = presenter
        fruitDetailRef.presenter?.view = fruitDetailRef
        fruitDetailRef.presenter?.router = FruitDetailRouter()
    }
    
    func goBackToFruitListView(from view: UIViewController) {
    }
    
    deinit {
        print("FruitDetailRouter removed")
    }
}
