//
//  ContentView.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/19/22.
//

import SwiftUI
import Combine


struct ContentView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var body: some View {
        NavigationView {
            List {
                NavigationLink { CounterView(store: store) } label: {
                    Text("Counter demo")
                }
                
                NavigationLink { FavoritePrimeView(store: store) } label: {
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





