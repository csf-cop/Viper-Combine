//
//  Films.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/4/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct Films: Codable {
    var count: Int = 0
    var all: [Film] = []

    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }

    init() { }

    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
    }
    init(from decoder: Decoder) throws {
        let values: KeyedDecodingContainer<Films.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
//        all = try values.decode(String.self, forKey: .all)
    }
}
