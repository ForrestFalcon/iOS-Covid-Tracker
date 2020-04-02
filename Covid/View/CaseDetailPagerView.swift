//
//  CaseDetailPagerView.swift
//  Covid
//
//  Created by Kevin Stieglitz on 02.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct CaseDetailPagerView: View {
    @State var page: Int = 0
    @State var countries: [Details]

    var body: some View {
        GeometryReader { proxy in
            Pager(page: self.$page,
                  data: self.countries,
                  id: \.self) {
                    CaseDetailCell(country: $0)
            }
            .padding(30)
            .rotation3D()
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct CaseDetailPagerView_Previews: PreviewProvider {
    static var previews: some View {
        CaseDetailPagerView(countries: [Details(country: "Demo", cases: 0, deaths: 0, recovered: 0, critical: 0), Details(country: "Demo2", cases: 0, deaths: 0, recovered: 0, critical: 0)])
    }
}
