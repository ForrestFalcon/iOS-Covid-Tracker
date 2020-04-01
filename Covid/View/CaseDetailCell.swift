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
    var data : Details

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(data.country)
                .fontWeight(.bold)

            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Active Cases")
                        .fontWeight(.bold)

                    Text(getValue(data: data.cases))
                        .font(.title)
                }

                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deaths")

                        Text(getValue(data: data.deaths))
                            .foregroundColor(.red)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recovered")

                        Text(getValue(data: data.recovered))
                            .foregroundColor(.green)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Critical")

                        Text(getValue(data: data.critical))
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailCell(data: Details(country: "Germany", cases: 0, deaths: 0, recovered: 0, critical: 0))
    }
}
