//
//  Historical.swift
//  Covid
//
//  Created by Kevin Stieglitz on 02.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

struct Historical : Decodable {
    var country : String
    var timeline : HistoricalTimeline
}

struct HistoricalTimeline : Decodable {
    var cases : [String: Int]
    var deaths : [String: Int]
    var recovered : [String: Int]
}
