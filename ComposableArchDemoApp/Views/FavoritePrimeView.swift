//
//  FavoritePrimeView.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import SwiftUI
import ComposableArchitecture


struct FavoritePrimeView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var body: some View {
        List {
            ForEach(store.value.favorites, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                store.send(.favoritesList(.deleteFavoritePrimes(indexSet)))
            }
        }
        .navigationTitle("Favorite Prime")
    }
}


struct FavoritePrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrimeView(store: .init(initialValue: AppState(), reducer: appReducer))
    }
}
