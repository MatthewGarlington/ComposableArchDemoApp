//
//  Counter.swift
//  Counter
//
//  Created by Matthew Garlington on 7/3/22.
//

import Foundation


public enum CounterAction {
    case decrCount
    case incrCount
}



public func counterReducer(state: inout Int, action: CounterAction) {
    switch action {
    case .decrCount:
        state -= 1
    case .incrCount:
        state += 1
    }
}
