//
//  AppReducer.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Combine
import Foundation

enum AppAction {
    case loadAllCases
    case setAllCases(case: AllCases, detail: [Details])
    case error
}

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let coronaService = CoronaService()

        return Reducer { state, action in

            switch action {
            case .error:
                state.loadAllCases = false
            case let .setAllCases(cases, details):
                state.allCases = cases
                state.countryCases = details
                state.loadAllCases = false

                log.info(cases)
                log.info(details)
            case .loadAllCases:
                state.loadAllCases = true
                return handleLoadAllCase(service: coronaService)
            }

            return nil
        }
    }

    private static func handleLoadAllCase(service: CoronaService) -> AnyPublisher<Action, Never> {
        return Publishers
            .Zip(service.fetchAllCases(), loadAllCountriesPublisher(service: service))
            .map { cases, details in
                Action.setAllCases(case: cases, detail: details)
            }
            .logError()
            .replaceError(with: AppAction.error)
            .eraseToAnyPublisher()
    }

    private static func loadAllCountriesPublisher(service: CoronaService) -> AnyPublisher<[Details], Error> {
        let fetchCountries = service.countries.map { country in
            service.fetchCountryCases(country: country)
        }

        return Publishers.MergeMany(fetchCountries)
            .collect()
            .map { details in details.sorted { $0.country < $1.country } } // sort list because reponses are different
            .eraseToAnyPublisher()
    }
}
