//
//  OptionalView.swift
//  Covid
//
//  Created by Kevin Stieglitz on 02.04.20.
//  Copyright © 2020 Kevin Stieglitz. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionalView<Value, Content>: View where Content: View {
    private var content: Content

    init?(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        guard let value = value else { return nil }
        self.content = content(value)
    }

    var body: some View {
        content
    }
}
