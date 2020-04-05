//
//  FruitsViewController.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

#warning("Fruit List page UI.")
final class FruitsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var fruits: [Fruit] = []
    var presenter: FruitsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fruits Screen"
        configTableUI()
        // Do any additional setup after loading the view.
        FruitsRouter.createFruitListModule(fruitListRef: self)
        presenter?.fetFruits()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FruitsViewController {

    private func configTableUI() {
        tableView.register(UITableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
}

extension FruitsViewController: FruitsViewProtocol {
    func showFruits(with fruits: [Fruit]) {
        self.fruits = fruits
        tableView.reloadData()
    }
}

extension FruitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeue(UITableViewCell.self)
        let fruit = fruits[indexPath.row]
        cell.textLabel?.text = fruit.name
        cell.detailTextLabel?.text = fruit.vitamin
        return cell
    }
}

extension FruitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showFruitSelection(with: fruits[indexPath.row], from: self)
    }
}

extension UITableView {
    public func register<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let bundle = Bundle.main
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellReuseIdentifier: name)
        } else {
            register(aClass, forCellReuseIdentifier: name)
        }
    }

    public func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
}
