//
//  AllCasesCell.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI

struct AllCasesCell: View {

    @EnvironmentObject
    private var store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 18) {
                    Text(getDate(time: self.store.state.allCases?.updated))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Covid - 19 Cases")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text(getValue(data: self.store.state.allCases?.cases))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }

                Spacer()

                Button(action: {
                    self.store.send(.loadAllCases)
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 18)
            .padding()
            .padding(.bottom, 80)
            .background(Color.red)

            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Deaths")
                        .foregroundColor(Color.black.opacity(0.5))

                    Text(getValue(data: self.store.state.allCases?.deaths))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }.padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(Color.white)
                    .cornerRadius(12)

                VStack(alignment: .leading, spacing: 15) {
                    Text("Recovered")
                        .foregroundColor(Color.black.opacity(0.5))

                    Text(getValue(data: self.store.state.allCases?.recovered))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }.padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(Color.white)
                    .cornerRadius(12)
            }
            .offset(y: -60)
            .padding(.bottom, -60)
            .zIndex(25)

            VStack(alignment: .center, spacing: 15) {
                Text("Active Cases")
                    .foregroundColor(Color.black.opacity(0.5))

                Text(getValue(data: self.store.state.allCases?.active))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
            }.padding(.horizontal)
                .padding(.vertical, 30)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.top, 15)
        }
    }
}

struct AllCasesCell_Previews: PreviewProvider {
    static var previews: some View {
        AllCasesCell().environmentObject(Store(initialState: AppState(), reducer: Reducer.appReducer()))
    }
}
