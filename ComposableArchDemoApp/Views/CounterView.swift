//
//  CounterView.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    @ObservedObject var store: Store<AppState, AppAction>
    @State private var nthPrimeAlert: Int?
    @State private var showModal: Bool = false
    @State private var showAlert: Bool = false
    var body: some View {
        VStack {
            HStack {
                Button { store.send(.counter(.decrCount))} label: { Text("-") }
                
                Text("\(store.value.count)")
                
                Button { store.send(.counter(.incrCount))} label: { Text("+") }
            }
            
            Button { showModal = true } label: {
                Text("Is this  Prime?")
            }
            
            Button {
                showAlert = true
                nthPrime(store.value.count) { prime in
                    nthPrimeAlert = prime
                }
            } label: {
                Text("What is the \(store.value.count)th prime?")
            }
        }
        .font(.title)
        .navigationTitle(Text("Counter demo"))
        .sheet(isPresented: $showModal) {
            PrimeModal(store: store)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""),
                  message: Text("The \(store.value.count)th prime is \(nthPrimeAlert ?? 0)"),
                  dismissButton: .cancel()
            )
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: .init(initialValue: AppState(), reducer: appReducer))
    }
}
