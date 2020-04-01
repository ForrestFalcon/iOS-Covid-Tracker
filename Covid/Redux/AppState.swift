//
//  AppState.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

struct AppState {
    var loadAllCases = false
    var countryCases = [Details]()
    var allCases: AllCases? = nil
}
