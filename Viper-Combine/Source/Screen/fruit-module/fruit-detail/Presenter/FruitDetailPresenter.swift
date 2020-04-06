//
//  FruitDetailPresenter.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class FruitDetailPresenter: FruitDetailPresenterProtocol {
    
    weak var view: FruitDetailViewProtocol?
    var router: FruitDetailRouterProtocol?
    var fruit: Fruit?
    
    func viewDidLoad() {
        view?.showFruitDetail(with: fruit!)
    }
    
    func backButtonPressed(from view: UIViewController) {
    }
    
    deinit {
        print("FruitDetailPresenter removed")
    }
}
