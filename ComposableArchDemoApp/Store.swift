//
//  Store.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import Foundation


class Store<Value, Action>: ObservableObject {
    let reducer: (inout Value, Action) -> Void
    @Published var value: Value
    
    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.reducer = reducer
        self.value = initialValue
    }
    
    func send(_ action: Action) {
      self.reducer(&value, action)
    }
}
