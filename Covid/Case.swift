//
//  Case.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation

struct Case : Decodable {
    var cases : Double
    var deaths : Double
    var updated : Double
    var recovered : Double
    var active : Double
}

struct Details : Decodable, Hashable {
    var country : String
    var cases : Double
    var deaths : Double
    var recovered : Double
    var critical : Double
}

class getData : ObservableObject {

    @Published var data : Case!
    @Published var countries = [Details]()

    init() {
        updateData()
    }

    func updateData() {
        let url = "https://corona.lmao.ninja/all"
        let url1 = "https://corona.lmao.ninja/countries/"

        let session = URLSession(configuration: .default)
        let session1 = URLSession(configuration: .default)

        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }

            let json = try! JSONDecoder().decode(Case.self, from: data!)

            DispatchQueue.main.async {
                self.data = json
            }
        }.resume()

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
