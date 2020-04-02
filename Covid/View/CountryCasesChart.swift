//
//  CountryCasesChart.swift
//  Covid
//
//  Created by Kevin Stieglitz on 02.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct CountryCasesChart: View {
    var title: String
    var data: [String: Int]?

    var body: some View {
        OptionalView(self.data) { chartdata in
            VStack {
                GeometryReader { _ in
                    //                BarChartView(data: ChartData(values: chartdata.map { ($0, $1) }),
                    //                             title: self.title,
                    //                             form: CGSize(width: proxy.size.width, height: proxy.size.height),
                    //                             dropShadow: false)

                    //                LineChartView(data: chartdata.sorted {
                    //                    guard let d1 = $0.key.coronaDate, let d2 = $1.key.coronaDate else { return false }
                    //                    return d1 < d2
                    //                }.map { Double($1) }, title: self.title,
                    //                              form: CGSize(width: proxy.size.width, height: proxy.size.height),
                    //                              dropShadow: false)
                    LineView(data: chartdata.sorted {
                        guard let d1 = $0.key.coronaDate, let d2 = $1.key.coronaDate else { return false }
                        return d1 < d2
                    }.map { Double($1) }, title: self.title, valueSpecifier: "%.0f")
                }
            }.padding()
        }
    }
}

struct CountryCasesChart_Previews: PreviewProvider {
    static var previews: some View {
        CountryCasesChart(title: "Demo", data: ["1": 0, "2": 3, "3": 40, "4": 100])
    }
}

extension String {
    static let coronaDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        return formatter
    }()

    var coronaDate: Date? {
        return String.coronaDate.date(from: self)
    }
}
