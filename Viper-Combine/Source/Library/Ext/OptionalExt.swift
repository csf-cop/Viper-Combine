//
//  OptionalExt.swift
//  Viper-Combine
//
//  Created by Tuan Dang Q. on 4/6/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation

extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }

    func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }
}
