//
//  Reducer.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import Foundation
import ComposableArchitecture
import FavoritePrimes
import Counter
import PrimeModal

enum AppAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
    case favoritesList(FavoritesPrimeActions)
    
    var counter: CounterAction? {
        get {
            guard case let .counter(value) = self else { return nil }
            return value
        }
        
        set {
            guard case .counter = self, let newValue = newValue else { return }
            self = .counter(newValue)
        }
    }
    
    var primeModel: PrimeModalAction? {
        get {
            guard case let .primeModal(value) = self else { return nil }
            return value
        }
        
        set {
            guard case .primeModal = self, let newValue = newValue else { return }
            self = .primeModal(newValue)
        }
    }
    
    var favoritePrimes: FavoritesPrimeActions? {
        get {
            guard case let .favoritesList(value) = self else { return nil }
            return value
        }
        set {
            guard case .favoritesList = self, let newValue = newValue else { return }
            self = .favoritesList(newValue)
        }
    }
}



func activityFeed(
    _ reducer: @escaping (inout AppState, AppAction) -> Void
) -> (inout AppState, AppAction) -> Void {
    return { state, action in
        switch action {
        case .counter:
            break
        case .primeModal(.removeFavoritePrimeTapped):
            state.activityFeed.append(.init(timeStap: Date(), type: .removedFavoritesPrime(state.count)))
            
        case .primeModal(.saveFavoritePrimeTapped):
            state.activityFeed.append(.init(timeStap: Date(), type: .addedFavoritesPrime(state.count)))
            
        case let .favoritesList(.deleteFavoritePrimes(indexSet)):
            for index in indexSet {
                state.activityFeed.append(.init(timeStap: Date(), type: .removedFavoritesPrime(index)))
            }
        }
        reducer(&state, action)
    }
}

extension AppState {
    var primeModal: PrimeModalState {
        get {
            PrimeModalState(
                count: self.count,
                favorites: self.favorites
            )
        }
        set {
            self.count = newValue.count
            self.favorites = newValue.favorites
        }
    }
}

let _appReducer: (inout AppState, AppAction) -> Void = combine(
    pullback(counterReducer, value: \.count, action: \.counter),
    pullback(primeModalReducer, value: \.primeModal, action: \.primeModel),
    pullback(favoriteListReducer, value: \.favorites, action: \.favoritePrimes)
)


let appReducer = combine(
    pullback(_appReducer, value: \.self)
)

