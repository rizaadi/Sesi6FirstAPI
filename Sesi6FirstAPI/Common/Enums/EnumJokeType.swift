//
//  EnumJokesType.swift
//  Sesi6FirstAPI
//
//  Created by Riza Adi Kurniawan on 03/02/24.
//

import Foundation

enum JokeType: String, CaseIterable, Identifiable {
    case general
    case knockKnock = "knock-knock"
    case programming
    case anime
    case food
    case dad
    
    var id: String {
        self.rawValue
    }
}
