//
//  JokeService.swift
//  filRouge
//
//  Created by Joris Thiery on 28/07/2021.
//

import Foundation
import Alamofire

typealias jokesCompletionHandler = ([Joke]?) -> Void

class JokeService {

    static let shared = JokeService()

    func jokes(completionHandler: @escaping jokesCompletionHandler) {

        AF.request("https://api.icndb.com/jokes/random/20").responseJSON { dataResponse in
            switch dataResponse.result {
            case .success:
                if let data = dataResponse.data {
                    print("DATA FROM SERVER: \(data)")
                    let jsonDecoder = JSONDecoder()
                    let jokesJSON = try! jsonDecoder.decode(JokeJSON.self, from: data)
                    let jokes = jokesJSON.value
                    completionHandler(jokes)
                } else {
                    completionHandler(nil)
                }
            case .failure(let error):
                print("ERROR DETECTED: \(error)")
                completionHandler(nil)
            }

        }
    }
}
