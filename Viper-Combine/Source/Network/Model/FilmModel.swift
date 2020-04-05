//
//  FilmModel.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/4/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

// MARK: The data properties and coding keys you need to pull data from the API’s film endpoint.
struct Film: Decodable {
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let starships: [String]

    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case starships
    }
}

struct FilmCollections: Codable {
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
        let values: KeyedDecodingContainer<FilmCollections.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decode(Int.self, forKey: .count)
        all = try values.decodeIfPresent([Film].self, forKey: .all) ?? []
    }
}
