//
//  FavoritePrimes.swift
//  FavoritePrimes
//
//  Created by Matthew Garlington on 7/2/22.
//

import SwiftUI
import ComposableArchitecture


public enum FavoritesPrimeActions {
    case deleteFavoritePrimes(IndexSet)
}


public func favoriteListReducer(state: inout [Int], action: FavoritesPrimeActions) {
    switch action {
    case let .deleteFavoritePrimes(indexSet):
        for index in indexSet {
            state.remove(at: index)
        }
    }
}


public struct FavoritePrimeView: View {
    @ObservedObject var store: Store<[Int], FavoritesPrimeActions>
    
    public init(store: Store<[Int], FavoritesPrimeActions>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            ForEach(store.value, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                store.send(.deleteFavoritePrimes(indexSet))
            }
        }
        .navigationTitle("Favorite Prime")
    }
}
