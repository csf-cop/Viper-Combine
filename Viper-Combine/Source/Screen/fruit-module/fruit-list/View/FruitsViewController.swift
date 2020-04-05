//
//  FruitsViewController.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import Combine

#warning("Fruit List page UI.")
final class FruitsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var subscriptions = Set<AnyCancellable>()
    var presenter: FruitsPresenterProtocol?
    var fruits: [Fruit] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    private var api = APIFilm()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fruits Screen"
        configTableUI()
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
        callAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FruitsViewController {
    private func callAPI() {
        
    }

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

struct APIFilm {
  
  //MARK: EndPoint
    enum EndPoint {
        static let baseURL = URL(string: "https://swapi.co")!
        case fetchFilmCollection

        var url: URL {
            switch self {
            case .fetchFilmCollection:
                return EndPoint.baseURL.appendingPathComponent("/api/films/")
            }
        }
    }
  
  //MARK: Properties
  private let decoder = JSONDecoder()
  private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
  
  //MARK: init
  init() { }
  
  //MARK: Public methods
  func fetchFilms(limit: Int) -> AnyPublisher<FilmCollections, ApiError> {
    return URLSession.shared
        .dataTaskPublisher(for: EndPoint.fetchFilmCollection.url)
        .subscribe(on: apiQueue)
        .tryMap { output in
            guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ApiError.invalidResponse
            }
            return output.data
        }
        .decode(type: FilmCollections.self, decoder: JSONDecoder())
        .mapError { error -> ApiError in
            switch error {
            case is URLError:
              return .errorURL
            case is DecodingError:
              return .errorParsing
            default:
              return error as? ApiError ?? .unknown
            }
        }
        .eraseToAnyPublisher()
    }
}
