//
//  Joke.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation

struct Joke: Codable, Identifiable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}
