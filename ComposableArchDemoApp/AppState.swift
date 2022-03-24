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

enum CounterAction {
    case decrCount
    case incrCount
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}

func counterReducer(state: inout AppState, action: CounterAction) {
    switch action {
    case .decrCount:
        state.count -= 1
    case .incrCount:
        state.count += 1
    case .saveFavoritePrimeTapped:
        fatalError()
    case .removeFavoritePrimeTapped:
        fatalError()
    }
}

