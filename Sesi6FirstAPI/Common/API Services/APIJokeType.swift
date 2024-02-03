//
//  APIJokeType.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation

class APIJokeType {
    static let shared = APIJokeType()
    
    private init(){}
    
    func fetchJokeByType(jokeType: JokeType) async throws -> Joke {
        let urlString = Constants.jokeAPI + "/type/\(jokeType.rawValue)/1"
        guard let url = URL(string: urlString) else {
            print("ERROR Could not convert \(urlString) to a URL")
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let jokes =  try JSONDecoder().decode([Joke].self, from: data)
        guard let firstJoke = jokes.first else {
            throw NSError(domain: "No Jokes found", code: 0, userInfo: nil)
        }
        return firstJoke
    }
}
