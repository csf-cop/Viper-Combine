//
//  GPRespose.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/5/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

struct GPResponse<Model>: Codable where Model: Codable {
    var error: String?
    var type: String?
    var message: String?
    var data: Model?
}
