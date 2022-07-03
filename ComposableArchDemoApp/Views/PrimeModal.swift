//
//  PrimeModal.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import SwiftUI
import ComposableArchitecture


struct PrimeModal: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var body: some View {
        if isPrime(store.value.count) {
            Text("\(store.value.count) is prime! 🎉")
            if store.value.favorites.contains(store.value.count) {
                Button {
                    store.send(.primeModal(.removeFavoritePrimeTapped))
                } label: {
                    Text("Remove favorite prims")
                }
            } else {
                Button {
                    store.send(.primeModal(.saveFavoritePrimeTapped))
                } label: {
                    Text("Save to favorites")
                }
            }
            
        } else{
            Text("\(store.value.count) is not prime 😟")
        }
        
    }
    
    private func isPrime (_ p: Int) -> Bool {
        if p <= 1 { return false }
        if p <= 3 { return true }
        for i in 2...Int(sqrtf(Float(p))) {
            if p % i == 0 { return false }
        }
        return true
    }
}


struct PrimeModal_Previews: PreviewProvider {
    static var previews: some View {
        PrimeModal(store: .init(initialValue: AppState(), reducer: appReducer))
    }
}
