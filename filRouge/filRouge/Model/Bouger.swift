//
//  Bouger.swift
//  filRouge
//
//  Created by Student04 on 21/10/2021.
//

import Foundation

struct BougerJSON: Codable{
    var businesses : [Places]?
    var total : Int?
    var region : RegionBouger?
}

struct Places : Codable{
    var name : String?
    var image_url : String?
    var isclosed : Bool
    // coordinate? plus tard
    var location : AddressBouger?
    var phone : String?
   var distance : Double?
    
}
struct AddressBouger: Codable {
    var address1 : String?
    var city : String?
    var zip_code : String?
    var country : String?
    var state : String?
}

struct RegionBouger: Codable{
    var center : CoordonneesRegionBouger?
}
struct CoordonneesRegionBouger: Codable{
    var latitude : Double?
    var longitude :Double?
}
