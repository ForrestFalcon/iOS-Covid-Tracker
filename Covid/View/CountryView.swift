//
//  CountryView.swift
//  Covid
//
//  Created by Kevin Stieglitz on 01.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct CountryView: View {
    var country: String

    @State var tabIndex: Int = 0

    @EnvironmentObject
    private var store: Store<CountryState, CountryAction>

    var body: some View {
//            if self.store.state.countryData {
//                BarChartView(data: ChartData(values: self.store.state.countryData.timeline.cases),
//                             title: "Sales", form: CGSize(width: 360, height: 320), dropShadow: false)
//            } else {
//                ActivityIndicator(style: .large)
//            }

        ActivityIndicatorView(isShowing: .constant(self.store.state.loadData)) {
            TabView(selection: self.$tabIndex) {
                CountryCasesChart(title: "Cases", data: self.store.state.countryData?.timeline.cases)
                    .tabItem { Group {
                        Image(systemName: "waveform.path.ecg")
                        Text("Cases")
                } }.tag(0)
                CountryCasesChart(title: "Recovered", data: self.store.state.countryData?.timeline.recovered)
                    .tabItem { Group {
                        Image(systemName: "arrow.up.right")
                        Text("Recovered")
                } }.tag(1)
                CountryCasesChart(title: "Deaths", data: self.store.state.countryData?.timeline.deaths)
                    .tabItem { Group {
                        Image(systemName: "arrow.down.right")
                        Text("Deaths")
                } }.tag(2)
            }
        }.onAppear {
            self.store.send(.loadCountryData(country: self.country))
        }.navigationBarTitle(Text(country))
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: "germany").environmentObject(Store(initialState: CountryState(
            loadData: false
        ), reducer: Reducer.countryReducer()))
    }
}
