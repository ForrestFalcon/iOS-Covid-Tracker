//
//  CoronaService.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation
import Combine

class CoronaService {
    private let baseUrl = "https://corona.lmao.ninja/"

    func fetchAllCases() -> AnyPublisher<AllCases, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: baseUrl + "all")!)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: AllCases.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum HTTPError: LocalizedError {
    case statusCode
}
