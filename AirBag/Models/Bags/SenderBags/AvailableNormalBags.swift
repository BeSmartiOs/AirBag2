//
//    AvailableNormalBag.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class AvailableNormalBag : NSObject, Mappable{
    
    var availableWeight : Int?
    var carrierRating : Float?
    var departure : String?
    var departureDatetime : String?
    var destination : String?
    var featured : Int?
    var id : Int?
    var kgPrice : Int?
    var views : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AvailableNormalBag()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        availableWeight <- map["available_weight"]
        carrierRating <- map["carrier_rating"]
        departure <- map["departure"]
        departureDatetime <- map["departure_datetime"]
        destination <- map["destination"]
        featured <- map["featured"]
        id <- map["id"]
        kgPrice <- map["kg_price"]
        views <- map["views"]
        
    }

    
}
