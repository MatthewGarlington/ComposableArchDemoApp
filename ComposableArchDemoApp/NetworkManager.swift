//
//  NetworkManager.swift
//  ComposableArchDemoApp
//
//  Created by Matthew Garlington on 3/24/22.
//

//import Foundation
//
//
//func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
//  var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
//  components.queryItems = [
//    URLQueryItem(name: "input", value: query),
//    URLQueryItem(name: "format", value: "plaintext"),
//    URLQueryItem(name: "output", value: "JSON"),
//    URLQueryItem(name: "appid", value: wolframAlphaApiKey),
//  ]
//
//  URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
//    callback(
//      data
//        .flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
//    )
//    }
//    .resume()
//}
//
//
//let wolframAlphaApiKey = "3G2GYG-WW3Y23KA7W"
