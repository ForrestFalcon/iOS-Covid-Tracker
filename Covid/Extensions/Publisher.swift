//
//  Publisher.swift
//  Covid
//
//  Created by Kevin Stieglitz on 01.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation
import Combine

extension Publisher {
    func logError() -> Publishers.MapError<Self, Self.Failure>{
        return self.mapError { error in
            log.error(error)
            return error
        }
    }
}
