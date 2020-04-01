//
//  ContentView.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store(initialState: AppState(), reducer: Reducer.appReducer()))
    }
}

struct Home: View {
    @EnvironmentObject
    private var store: Store<AppState, AppAction>

    @ObservedObject var data = getData()

    var body: some View {
        ActivityIndicatorView(isShowing: .constant(self.store.state.loadAllCases)) {
            VStack {
                AllCasesCell()

                if self.data.countries.count != 0 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(self.data.countries, id: \.self) { i in
                                CaseDetailCell(data: i)
                            }
                        }
                        .padding()

                        Spacer()
                    }
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

func getDate(time: Double?) -> String {
    guard let d = time else {
        return "-"
    }

    let date = Double(d / 1000)
    let format = DateFormatter()
    format.dateFormat = "MMM - dd - YYYY hh:mm a"

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
