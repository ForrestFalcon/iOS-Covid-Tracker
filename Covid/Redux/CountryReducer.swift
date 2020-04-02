//
//  CountryReducer.swift
//  Covid
//
//  Created by Kevin Stieglitz on 02.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Combine
import Foundation

enum CountryAction {
    case loadCountryData(country: String)
    case setCountryData(data: Historical)
    case error
}

extension Reducer where State == CountryState, Action == CountryAction {
    static func countryReducer() -> Reducer {
        let coronaService = CoronaService()

        return Reducer { state, action in

            switch action {
            case .error:
                state.loadData = false
            case let .setCountryData(data):
                state.countryData = data
                state.loadData = false
                log.info(data)
            case let .loadCountryData(country):
                state.loadData = true
                return handleLoadCountryData(service: coronaService, country: country)
            }

            return nil
        }
    }

    private static func handleLoadCountryData(service: CoronaService, country: String) -> AnyPublisher<Action, Never> {
        return service.fetchHistoricalCases(country: country)
            .map { Action.setCountryData(data: $0) }
            .logError()
            .replaceError(with: CountryAction.error)
            .eraseToAnyPublisher()
    }
}
