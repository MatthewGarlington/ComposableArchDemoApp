//
//  ComposableArchitecture.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 7/2/22.
//

import SwiftUI
import Combine

public final class Store<Value, Action>: ObservableObject {
    public let reducer: (inout Value, Action) -> Void
    @Published public var value: Value
    private var cancellable: Cancellable?
    
    public init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.reducer = reducer
        self.value = initialValue
    }
    
    public func send(_ action: Action) {
      self.reducer(&value, action)

    }
    
    public func view<LocalValue, LocalAction>(
        value toLocalValue: @escaping (Value) -> LocalValue,
        action toGlobalAction: @escaping (LocalAction) -> Action
    ) -> Store<LocalValue, LocalAction> {
        let localStore = Store<LocalValue, LocalAction>(
            initialValue: toLocalValue(self.value),
            reducer: { localValue, localAction in
                self.send(toGlobalAction(localAction))
                localValue = toLocalValue(self.value)
            }
        )
        localStore.cancellable = self.$value.sink { [weak localStore] newValue in
            localStore?.value = toLocalValue(newValue)
        }
        return localStore
    }
}




public func logging<Value, Action>(
    _ reducer: @escaping (inout Value, Action) -> Void
) -> (inout Value, Action) -> Void {
    return { value, action in
        reducer(&value, action)
        print("Action: \(action)")
        print("Value:")
        dump(value)
        print("----")
    }
}

public func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
    _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
    value: WritableKeyPath<GlobalValue, LocalValue>,
    action: WritableKeyPath<GlobalAction, LocalAction?>
) -> (inout GlobalValue, GlobalAction) -> Void {
    return { globalValue, globalAction in
        guard let localAction = globalAction[keyPath: action] else { return }
        reducer(&globalValue[keyPath: value], localAction)
    }
}


public func pullback<LocalValue, GlobalValue, Action>(
    _ reducer: @escaping (inout LocalValue, Action) -> Void, value: WritableKeyPath<GlobalValue, LocalValue>
) -> (inout GlobalValue, Action) -> Void {
    return { globalValue, action in
        reducer(&globalValue[keyPath: value], action)
        
    }
}


public func combine<Value, Action>(
    _ reducers: (inout Value, Action) -> Void...
) -> (inout Value, Action) -> Void  {
    return  { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}


