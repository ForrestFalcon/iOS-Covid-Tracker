//
//  Detail.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

struct Details : Decodable, Hashable {
    var country : String
    var cases : Double
    var deaths : Double
    var recovered : Double
    var critical : Double
}
