//
//  CoronaService.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Combine
import Foundation

class CoronaService {
    private let baseUrl = "https://corona.lmao.ninja/"
    let countries = ["italy", "germany", "usa", "spain", "austria"]

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

    func fetchCountryCases(country: String) -> AnyPublisher<Details, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: baseUrl + "countries/" + country)!)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: Details.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchHistoricalCases(country: String) -> AnyPublisher<Historical, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: baseUrl + "v2/historical/" + country)!)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: Historical.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum HTTPError: LocalizedError {
    case statusCode
}
