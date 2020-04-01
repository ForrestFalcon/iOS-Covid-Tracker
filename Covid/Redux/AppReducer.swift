//
//  AppReducer.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Combine
import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let coronaService = CoronaService()

        return Reducer { state, action in

            switch action {
            case .loadCasesInfo:
                return handleAllCases(service: coronaService)
            case let .setCasesInfo(cases):
                state.allCases = cases
            case .error:
                state.loadAllCases = false
            case .loadAllCountries:
                return handleLoadAllCountries(service: coronaService)
            case let .setCountryDetails(details):
                state.countryCases = details
            case let .setAllCases(cases, details):
                state.allCases = cases
                state.countryCases = details
                state.loadAllCases = false
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

    private static func handleAllCases(service: CoronaService) -> AnyPublisher<Action, Never> {
        return service.fetchAllCases()
            .map { cases -> Action in
                log.info(cases)
                let test = AppAction.setCasesInfo(case: cases)
                return test
            }
            .logError()
            .replaceError(with: AppAction.error)
            .eraseToAnyPublisher()
    }

    private static func handleLoadAllCountries(service: CoronaService) -> AnyPublisher<Action, Never> {
        return loadAllCountriesPublisher(service: service)
            .map { details in
                Action.setCountryDetails(detail: details)
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
