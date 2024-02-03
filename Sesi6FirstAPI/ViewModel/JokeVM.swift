//
//  JokeVM.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation

class JokeVM: ObservableObject {
    @Published var joke: Joke?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var jokesTypes: [JokeType] = JokeType.allCases
    @Published var selectedJokeType: JokeType = .general
    
    func fetchJoke() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
//            let fetchedJoke  = try await APIService.shared.fetchJokeServices()
            let fetchedJoke  = try await APIJokeType.shared.fetchJokeByType(jokeType: selectedJokeType)
            DispatchQueue.main.async {
                self.joke = fetchedJoke
                print("Setup \(self.joke?.setup ?? "No Setup")")
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                print("ERROR: could not get data from url \(Constants.jokeAPI). \(error.localizedDescription)")
            }
        }
        
    }
}
