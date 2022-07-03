//
//  FavoritePrimes.swift
//  FavoritePrimes
//
//  Created by Matthew Garlington on 7/2/22.
//

import Foundation


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
