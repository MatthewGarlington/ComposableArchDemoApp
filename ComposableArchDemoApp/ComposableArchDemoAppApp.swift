//
//  ComposableArchDemoAppApp.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/19/22.
//

import SwiftUI
import Overture
import ComposableArchitecture

@main



struct ComposableArchDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialValue: AppState(),
                reducer: with(
                    appReducer,
                    compose(
                        logging,
                        activityFeed
                    )
                )
            )
            )
            .preferredColorScheme(.light)
        }
    }
}
