//
//  Joke.swift
//  filRouge
//
//  Created by Joris Thiery on 28/07/2021.
//

import Foundation

struct JokeJSON: Codable {
    var type: String
    var value: [Joke]
}

struct Joke: Codable {
    var id: Int
    var joke: String
}
