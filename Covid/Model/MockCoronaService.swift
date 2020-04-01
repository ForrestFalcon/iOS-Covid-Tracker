//
//  MockCoronaService.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

class MockCoronaService : CoronaService {
    private let baseUrl = "https://corona.lmao.ninja/"


    func fetchAllCases() -> Case {

        URLSession.shared.dataTaskPublisher(for: URL(string: baseUrl + "all")!)
            .map { $0.data }
            .decode(type: Case.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        return Case(cases: 42, deaths: 2, updated: 100, recovered: 10, active: 32)
    }
}
