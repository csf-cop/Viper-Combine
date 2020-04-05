//
//  FruitsInteractor.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import Alamofire

#warning("Fruit List module’s business logic and handlings.")
class FruitsInteractor: FruitsInputInteractorProtocol {
    weak var presenter: FruitsOutputInteractorProtocol?

    func getFruitList() {
        presenter?.fruitListDidFetch(fruitList: getAllFruitDetail())
    }

    // MARK: Call API fetch film (cause have no Fruit API)
    func getAllFruitDetail() -> [Fruit] {

        callAPI()

        var fruitList: [Fruit] = [Fruit]()
        let allFruitDetail: [[String: String]] = [["name": "Orange","vitamin": "Vitain C"], ["name": "Watermelon","vitamin": "Vitain A"], ["name": "Banana","vitamin": "Vitain B6"], ["name": "Apple","vitamin": "Vitain C"]]

        for item in allFruitDetail {
            fruitList.append(Fruit(attributes: item))
        }
        return fruitList
    }

    private func callAPI(isUseStub: Bool = false) {
        let provider: FilmsProvider = FilmsProvider()
        provider.fetchFilms(isUseStub: true) { [weak self] result in
            guard let this = self else {
                print("This fail.")
                return
            }
            switch result {
            case .success(let value):
                guard let data: Films = value else {
                    print("Cast fail.")
                    return
                }
                print("data: \(data)")
                print("Fetch data ok")
            case .error(let e):
                print("Error happen: \(e.localizedDescription)")
            }
        }
        
        
        let url: String = "https://swapi.co/api/films"
        #warning("converting the response into JSON.")
//        let request = AF.request(url)
//        request.responseJSON { (data) in
//          print(data)
//        }

        #warning("convert it into your internal data model, Films.")
//        request.responseDecodable(of: Films.self) { (response) in
//          guard let films = response.value else { return }
//          print(films.all[0].title)
//        }
        //        let url: String = "https://swapi.co/api/films"
        //        // MARK: Method Chaining - Connecting the response of one method as the input of another.
        //        AF.request(url)
        //            .validate()
        //            .responseDecodable(of: Films.self) { (response) in
        //                guard let films = response.value else { return }
        //                print(films.all[0].title)
        ////                for item in films.all {
        ////                    fruitList.append(Fruit(attributes: ["name": item.title,"vitamin": item.producer]))
        ////                }
        //        }
    }
}

extension String {
    func convertFileToData() -> Data {
        guard let path = Bundle.main.path(forResource: self, ofType: "json") else {
            fatalError("Can not convert to path for \(self).json")
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Can not get data from \(self).json")
        }
        return data
    }
}
