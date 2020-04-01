//
//  Store.swift
//  Covid
//
//  Created by Kevin Stieglitz on 31.03.20.
//  from https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui/
//

import Combine
import Foundation

final class Store<State, Action>: ObservableObject {
    // MARK: Stored properties

    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>
    private var effectCancellables: Set<AnyCancellable> = []

    // MARK: Initialization

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    // MARK: Methods

    func send(_ action: Action) {
        guard let effect = reducer.reduce(&state, action) else {
            return
        }

        var didComplete = false
        var cancellable: AnyCancellable?

        cancellable = effect
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    didComplete = true

                    if cancellable != nil {
                        self?.effectCancellables.remove(cancellable!)
                    }
                }, receiveValue: send)

        if !didComplete, let cancellable = cancellable {
            effectCancellables.insert(cancellable)
        }
    }
}
