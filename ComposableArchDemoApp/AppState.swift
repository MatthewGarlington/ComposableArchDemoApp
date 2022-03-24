//
//  AppState.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import Foundation



struct AppState {
     var count = 0
     var favorites: [Int] = []
     var loggedInUser: User? = nil
     var activityFeed: [Activity] = []
    
    struct Activity {
        let timeStap: Date
        let type: ActivityType
        
        enum ActivityType {
            case addedFavoritesPrime(Int)
            case removedFavoritesPrime(Int)
        }
    }
    
    struct User {
        var id: Int
        var name: String
        var bio: String
    }
}

enum PrimeModalAction {

    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}

enum CounterAction {
    case decrCount
    case incrCount
}

enum FavoritesPrimeActions {
    case deleteFavoritePrimes(IndexSet)
}

enum AppAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
    case favoritesList(FavoritesPrimeActions)
}

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .counter(.decrCount):
        state.count -= 1
    case .counter(.incrCount):
        state.count += 1
    case .primeModal(.saveFavoritePrimeTapped):
        state.favorites.append(state.count)
    case .primeModal(.removeFavoritePrimeTapped):
        state.favorites.removeAll(where: { $0 == state.count})
    case let .favoritesList(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            state.favorites.remove(at: index)
        }
    }
}

