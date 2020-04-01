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
            case .loadAllCases:
                state.loadAllCases = true
                return handleAllCases(service: coronaService)
            case let .setAllCases(cases):
                state.allCases = cases
                state.loadAllCases = false
            case .error:
                state.loadAllCases = false
            }

            return nil
        }
    }

    private static func handleAllCases(service: CoronaService) -> AnyPublisher<Action, Never> {
        return service.fetchAllCases()
            .map { cases -> Action in
                log.info(cases)
                return AppAction.setAllCases(case: cases)
            }
            .logError()
            .replaceError(with: AppAction.error)
            .eraseToAnyPublisher()
    }
}
