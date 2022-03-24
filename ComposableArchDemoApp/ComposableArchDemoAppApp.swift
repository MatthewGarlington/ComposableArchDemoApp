//
//  ComposableArchDemoAppApp.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/19/22.
//

import SwiftUI

@main
struct ComposableArchDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(initialValue: AppState(), reducer: appReducer))
        }
    }
}
