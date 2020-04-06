//
//  FruitDetailProtocol.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

protocol FruitDetailPresenterProtocol: class {
    
    var router: FruitDetailRouterProtocol? { get set }
    var view: FruitDetailViewProtocol? { get set }
    
    //View -> Presenter
    func viewDidLoad()
    func backButtonPressed(from view: UIViewController)
    
}

protocol FruitDetailViewProtocol: class {
    //Presenter -> View
    func showFruitDetail(with fruit: Fruit)
}

protocol FruitDetailRouterProtocol: class {
    func goBackToFruitListView(from view: UIViewController)
}
