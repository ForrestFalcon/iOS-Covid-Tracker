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

class getData : ObservableObject {

    @Published var data : AllCases!
    @Published var countries = [Details]()

    init() {
        updateData()
    }

    func updateData() {
        let url1 = "https://corona.lmao.ninja/countries/"

        let session1 = URLSession(configuration: .default)

        for i in country {

            session.dataTask(with: URL(string: url1 + i)!) { (data, _, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }

                let json = try! JSONDecoder().decode(Details.self, from: data!)

                DispatchQueue.main.async {
                    self.countries.append(json)
                }
            }.resume()
        }
    }
 }

var country = ["italy", "germany", "usa", "spain", "australia"]
