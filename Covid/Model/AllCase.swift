//
//  Case.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

struct AllCases : Decodable {
    var cases : Double
    var deaths : Double
    var updated : Double
    var recovered : Double
    var active : Double
}
