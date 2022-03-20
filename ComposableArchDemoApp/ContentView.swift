//
//  ContentView.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/19/22.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var count = 0
    @Published var favorites: [Int] = []
}

struct ContentView: View {
    @State private var count = 0
    @State private var favoritePrimes: [Int] = []
    var body: some View {
        NavigationView {
            List {
                NavigationLink { CounterView(count: $count, favoritePrimes: $favoritePrimes) } label: {
                    Text("Counter demo")
                }
                
                NavigationLink { FavoritePrimeView(favoritePrimes: $favoritePrimes) } label: {
                    Text("Favorites primes")
                }
            }
            .navigationTitle("State Management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CounterView: View {
    @Binding var count: Int
    @Binding var favoritePrimes: [Int]
    @State private var nthPrimeAlert: Int?
    @State private var showModal: Bool = false
    @State private var showAlert: Bool = false
    var body: some View {
        VStack {
            HStack {
                Button { count -= 1 } label: {
                    Text("-")
                }
                
                Text("\(count)")
                
                Button { count += 1} label: {
                    Text("+")
                }
            }
            Button { showModal = true } label: {
                Text("Is this  Prime?")
            }
            
            Button {
                showAlert = true
                nthPrime(count) { prime in
                    nthPrimeAlert = prime
                }
            } label: {
                Text("What is the \(count)th prime?")
            }
        }
        .font(.title)
        .navigationTitle(Text("Counter demo"))
        .sheet(isPresented: $showModal) {
            PrimeModal(count: $count, favoritePrimes: $favoritePrimes)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""), message: Text("The \(count)th prime is \(nthPrimeAlert ?? 0)"), dismissButton: .cancel())
        }
    }
}


struct PrimeModal: View {
    @Binding var count: Int
    @Binding var favoritePrimes: [Int]
    var body: some View {
        if isPrime(count) {
            Text("\(count) is prime! 🎉")
            if favoritePrimes.contains(count) {
                Button {
                    favoritePrimes.removeAll(where: { $0 == count})
                } label: {
                    Text("Remove favorite prims")
                }
            } else {
                Button {
                    favoritePrimes.append(count)
                } label: {
                    Text("Save to favorites")
                }
            }
            
        } else{
            Text("\(count) is not prime 😟")
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

struct WolframAlphaResult: Decodable {
    let queryresult: QueryResult
    
    struct QueryResult: Decodable {
        let pods: [Pod]
        
        struct Pod: Decodable {
            let primary: Bool?
            let subpods: [SubPod]
            
            struct SubPod: Decodable {
                let plaintext: String
            }
        }
    }
}

func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
  var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
  components.queryItems = [
    URLQueryItem(name: "input", value: query),
    URLQueryItem(name: "format", value: "plaintext"),
    URLQueryItem(name: "output", value: "JSON"),
    URLQueryItem(name: "appid", value: wolframAlphaApiKey),
  ]

  URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
    callback(
      data
        .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
    )
    }
    .resume()
}

func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
  wolframAlpha(query: "prime \(n)") { result in
    callback(
      result
        .flatMap {
          $0.queryresult
            .pods
            .first(where: { $0.primary == .some(true) })?
            .subpods
            .first?
            .plaintext
        }
        .flatMap(Int.init)
    )
  }
}

let wolframAlphaApiKey = "3G2GYG-WW3Y23KA7W"


struct FavoritePrimeView: View {
    @Binding var favoritePrimes: [Int]
    var body: some View {
        List {
            ForEach(favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationTitle("Favorite Prime")
    }
}
