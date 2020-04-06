//
//  FruitDetailViewController.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class FruitDetailViewController: UIViewController {
    @IBOutlet var fruitNameLabel: UILabel!
    @IBOutlet var vitaminLabel: UILabel!

    var presenter: FruitDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("FruitDetailView removed")
    }
}

extension FruitDetailViewController: FruitDetailViewProtocol {
    func showFruitDetail(with fruit: Fruit) {
        title = fruit.name
        fruitNameLabel.text = fruit.name
        vitaminLabel.text = fruit.vitamin
    }
}
