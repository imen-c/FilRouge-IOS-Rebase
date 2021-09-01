//
//  EatService.swift
//  filRouge
//
//  Created by Student04 on 01/09/2021.
//

import Foundation
import Network
import Alamofire
typealias eatsCompletionHandler = ([Resto]?) -> Void

class EatService{
    static let shared = EatService()

    
    func eats(completionHandler : @escaping eatsCompletionHandler){
    let headers : HTTPHeaders = [
        "Authorization " : "Basic HIDoGGdojcL__53LiCdiYMFAOb3BwjGJubVSrXWaiaf18pCPg-kcOhMfGlgYed49WO5CLsAk7zGSX5KZCogK2VALtSu_X489y2ODvymFnAkE2CzWld8d9ZmUAjIvYXYx",
        "Accept":"application/json"
    
    ]
        let parameters : [String : Any] = [
            "term": "food",
            "latitude": "50.59379456353284",
            "longitude" : "5.5600",
            "limit" : "5",
            
        ]
        AF.request("https://api.yelp.com/v3/businesses/search", parameters: parameters, headers :headers).responseJSON{dataResponse in
            switch dataResponse.result{
            case.success:
                if let data = dataResponse.data{
                    print("DATA FROM SERVER: \(data)")
                    let jsonDecoder = JSONDecoder()
                    let yelpJSON = try! jsonDecoder.decode(YelpJSON.self, from: data)
                    let eats = yelpJSON.businesses
                    completionHandler(eats)
                }else {
                    completionHandler(nil)
                }
            case.failure(let error):
                print("ERROR DETECTED: \(error)")
                completionHandler(nil)
            
        }
    
    
    }
}
}


