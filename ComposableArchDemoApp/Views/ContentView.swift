//
//  ContentView.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/19/22.
//

import SwiftUI
import Combine
import ComposableArchitecture
import FavoritePrimes


struct ContentView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var body: some View {
        NavigationView {
            List {
                NavigationLink { CounterView(store: store.view(
                    value: { ($0.count, $0.favorites) },
                    action: {
                        switch $0 {
                        case let .counter(action):
                            return .counter(action)
                        case let .primeModal(action):
                            return .primeModal(action)
                        }
                    })
                )
                    
                } label: {
                    Text("Counter demo")
                }
                
                NavigationLink { FavoritePrimeView(
                    store: store.view(
                        value: { $0.favorites },
                        action: { .favoritesList($0) })
                )
                } label: {
                    Text("Favorites primes")
                }
            }
            .navigationTitle("State Management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: .init(initialValue: AppState(), reducer: appReducer))
    }
}





