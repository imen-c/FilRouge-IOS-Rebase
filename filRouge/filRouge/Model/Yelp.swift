//
//  Yelp.swift
//  filRouge
//
//  Created by Student04 on 01/09/2021.
//

import Foundation

struct YelpJSON: Codable{
    var businesses : [Resto]?
    var total : Int?
    var region : Region?
}

struct Resto : Codable{
    var alias : String?
    var image_url : String?
    var url : String?
  var categories : [Categories]?
    //var coordinates : [Coordonnees]?
    //var location : [Address]?
    var phone : String?
   var distance : Double?
    
}
struct Categories : Codable{
    var alias : String?
    var title : String?
}
struct Coordonnees : Codable{
    var latitude : Double?
    var longitude : Double?
}
struct Address : Codable {
    var address1 : String?
    var city : String?
    var zip_code : String?
    var country : String?
    var state : String?
}
struct Region : Codable{
    var center : CoordonneesRegion?
}
struct CoordonneesRegion : Codable{
    var latitude : Double?
    var longitude : Double?
}
