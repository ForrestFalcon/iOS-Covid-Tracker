//
//  CaseDetailCell.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation
import SwiftUI

struct CaseDetailCell: View {
    var country: Details

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(country.country)
                .fontWeight(.bold)

            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Active Cases")
                        .fontWeight(.bold)

                    Text(getValue(data: country.cases))
                        .font(.title)
                }

                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deaths")

                        Text(getValue(data: country.deaths))
                            .foregroundColor(.red)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recovered")

                        Text(getValue(data: country.recovered))
                            .foregroundColor(.green)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Critical")

                        Text(getValue(data: country.critical))
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailCell(country: Details(country: "Germany", cases: 0, deaths: 0, recovered: 0, critical: 0)).padding()
    }
}
