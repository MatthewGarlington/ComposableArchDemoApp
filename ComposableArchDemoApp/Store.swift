////
////  Store.swift
////  ComposableArchDemoApp
////
////  Created by Matthew Garlington on 3/24/22.
////
//
//import Foundation
//
//
//func logging<Value, Action>(
//    _ reducer: @escaping (inout Value, Action) -> Void
//) -> (inout Value, Action) -> Void {
//    return { value, action in
//        reducer(&value, action)
//        print("Action: \(action)")
//        print("Value:")
//        dump(value)
//        print("----")
//    }
//}
//
//
//final class Store<Value, Action>: ObservableObject {
//    let reducer: (inout Value, Action) -> Void
//    @Published var value: Value
//    
//    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
//        self.reducer = reducer
//        self.value = initialValue
//    }
//    
//    func send(_ action: Action) {
//      self.reducer(&value, action)
//
//    }
//}
//
//func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
//    _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
//    value: WritableKeyPath<GlobalValue, LocalValue>,
//    action: WritableKeyPath<GlobalAction, LocalAction?>
//) -> (inout GlobalValue, GlobalAction) -> Void {
//    return { globalValue, globalAction in
//        guard let localAction = globalAction[keyPath: action] else { return }
//        reducer(&globalValue[keyPath: value], localAction)
//    }
//}
//
//
//func pullback<LocalValue, GlobalValue, Action>(
//    _ reducer: @escaping (inout LocalValue, Action) -> Void, value: WritableKeyPath<GlobalValue, LocalValue>
//) -> (inout GlobalValue, Action) -> Void {
//    return { globalValue, action in
//        reducer(&globalValue[keyPath: value], action)
//        
//    }
//}
//
//
//func combine<Value, Action>(
//    _ reducers: (inout Value, Action) -> Void...
//) -> (inout Value, Action) -> Void  {
//    return  { value, action in
//        for reducer in reducers {
//            reducer(&value, action)
//        }
//    }
//}
//
