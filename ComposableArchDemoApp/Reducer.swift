//
//  Reducer.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import Foundation



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

func counterReducer(state: inout Int, action: AppAction) {
    switch action {
    case .counter(.decrCount):
        state -= 1
        
    case .counter(.incrCount):
        state += 1
    default: break
    }
}

func primeModalReducer(state: inout AppState, action: AppAction) {
    switch action {

    case .primeModal(.saveFavoritePrimeTapped):
        state.favorites.append(state.count)
        
    case .primeModal(.removeFavoritePrimeTapped):
        state.favorites.removeAll(where: { $0 == state.count })
                                       
    default: break
                                
    }
}

struct FavoritePrimesState {
    var favorites: [Int]
}

func favoriteListReducer(state: inout FavoritePrimesState, action: AppAction) {
    switch action {
    case let .favoritesList(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            state.favorites.remove(at: index)
        }
    default: break
}
}

let _appReducer = combine(
    pullback(counterReducer, value: \.count),
    primeModalReducer,
    pullback(favoriteListReducer, value: \.favoritePrimeState)
)

extension AppState {
    var favoritePrimeState: FavoritePrimesState {
        get {
            FavoritePrimesState(favorites: self.favorites)
        }
        set {
            self.favorites = newValue.favorites
        }
    }
}

let appReducer = combine(
    pullback(_appReducer, value: \.self)
)

func combine<Value, Action>(
    _ reducers: (inout Value, Action) -> Void...
) -> (inout Value, Action) -> Void  {
    return  { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}

func pullback<LocalValue, GlobalValue, Action>(
    _ reducer: @escaping (inout LocalValue, Action) -> Void, value: WritableKeyPath<GlobalValue, LocalValue>
) -> (inout GlobalValue, Action) -> Void {
    return { globalValue, action in
        reducer(&globalValue[keyPath: value], action)
        
    }
}
