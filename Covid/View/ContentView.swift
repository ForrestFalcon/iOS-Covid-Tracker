//
//  ContentView.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct ContentView: View {
    @EnvironmentObject
    private var store: Store<AppState, AppAction>

    var body: some View {
        ActivityIndicatorView(isShowing: .constant(self.store.state.loadAllCases)) {
            VStack {
                AllCasesCell()

                if self.store.state.countryCases.count != 0 {
                    CaseDetailPagerView(countries: self.store.state.countryCases)
                } else {
                    Spacer()
                }
            }.edgesIgnoringSafeArea(.top)
                .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
        }.onAppear {
            self.store.send(.loadAllCases)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store(initialState: AppState(), reducer: Reducer.appReducer()))
    }
}

func getDate(time: Double?) -> String {
    guard let d = time else {
        return "-"
    }

    let date = Double(d / 1000)
    let format = DateFormatter()
    format.dateStyle = .medium
    format.timeStyle = .medium

    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}

func getValue(data: Double?) -> String {
    guard let d = data else {
        return "-"
    }

    let format = NumberFormatter()
    format.numberStyle = .decimal
    return format.string(for: d)!
}
