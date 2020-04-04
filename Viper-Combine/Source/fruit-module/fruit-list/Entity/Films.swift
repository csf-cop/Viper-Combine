//
//  Films.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/4/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let all: [Film]

    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
