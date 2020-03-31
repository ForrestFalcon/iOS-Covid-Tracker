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
        ContentView()
    }
}

struct Home: View {

    @ObservedObject var data = getData()

    var body: some View {
        VStack {
            if self.data.countries.count != 0 && self.data.data != nil {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 18) {
                            Text(getDate(time: self.data.data.updated))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Covid - 19 Cases")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(getValue(data: self.data.data.cases))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Button(action: {
                            self.data.data = nil
                            self.data.countries.removeAll()
                            self.data.updateData()
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

                            Text(getValue(data: self.data.data.deaths))
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

                            Text("3655")
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

                        Text(getValue(data: self.data.data.active))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }.padding(.horizontal)
                        .padding(.vertical, 30)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.top, 15)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(self.data.countries, id: \.self) { i in
                                CellView(data : i)
                            }
                        }
                        .padding()

                        Spacer()
                    }
                }
            } else {
                GeometryReader{_ in
                    VStack {
                        ActivityIndicator(style: .large)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.top)
            .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

func getDate(time: Double) -> String {
    let date = Double(time / 1000)
    let format = DateFormatter()
    format.dateFormat = "MMM - dd - YYYY hh:mm a"

    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}

func getValue(data : Double) -> String {
    let format = NumberFormatter()
    format.numberStyle = .decimal
    return format.string(for: data)!
}
