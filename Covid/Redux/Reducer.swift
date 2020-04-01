//
//  Reducer.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Combine
import Foundation

struct Reducer<State, Action> {
    let reduce: (inout State, Action) ->  AnyPublisher<Action, Never>?
}
