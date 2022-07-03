//
//  PrimeModal.swift
//  PrimeModal
//
//  Created by Matthew Garlington on 7/3/22.
//

import Foundation

public enum PrimeModalAction {
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}


public struct PrimeModalState {
    public var count: Int
    public var favorites: [Int]
    
    public init (
        count: Int, favorites: [Int]
    ) {
        self.count = count
        self.favorites = favorites
    }
}


public func primeModalReducer(state: inout PrimeModalState, action: PrimeModalAction) {
    switch action {
    case  .saveFavoritePrimeTapped:
        state.favorites.append(state.count)
        
    case .removeFavoritePrimeTapped:
        state.favorites.removeAll(where: { $0 == state.count })
      
    }
}
