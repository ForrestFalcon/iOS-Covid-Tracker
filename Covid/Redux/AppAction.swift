//
//  AppAction.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

enum AppAction {
    case loadCasesInfo
    case setCasesInfo(case: AllCases)
    case setCountryDetails(detail: [Details])
    case loadAllCountries
    case loadAllCases
    case setAllCases(case: AllCases, detail: [Details])
    case error
}
