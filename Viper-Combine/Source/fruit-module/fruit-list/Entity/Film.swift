//
//  Film.swift
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
