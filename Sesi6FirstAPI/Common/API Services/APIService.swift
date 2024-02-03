//
//  APIService.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation

class APIService {
    static let shared = APIService() // Singleton Design Pattern
    private init() {}
    
    func fetchJokeServices() async throws -> Joke {
        let urlString = URL(string: Constants.jokeAPI)
        guard let url = urlString else {
            print("ERROR could not convert \(String(describing: urlString)) to a URL")
            throw URLError(.badURL)
        }
        
        let (data, response) =  try await URLSession.shared.data(from: url)
        
        //        check if httResponse is HTTPURLResponse otherwise throw error
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        //        check if status code is 200 to 299 otherwise throw error
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        let joke = try JSONDecoder().decode(Joke.self, from: data)
        
        return joke
    }
}
