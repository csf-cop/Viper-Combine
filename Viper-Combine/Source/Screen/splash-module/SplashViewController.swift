//
//  SplashViewController.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.isToolbarHidden = true
    }
    @IBAction func fruitsTouchUpInside(_ sender: UIButton) {
        let viewController: FruitsViewController = FruitsViewController()
        viewController.presenter = FruitsPresenter()
//        let navi: UINavigationController = UINavigationController(rootViewController: viewController)
//        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = navi
        navigationController?.pushViewController(viewController, animated: true)
    }
}
