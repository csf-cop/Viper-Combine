//
//  Fruit.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/3/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

#warning("Model class of our Fruits.")
struct Fruit {
    var name: String = ""
    var vitamin: String = ""
    
    init(attributes: [String: String]) {
        self.name = attributes["name"] ?? ""
        self.vitamin = attributes["vitamin"] ?? ""
    }
}
