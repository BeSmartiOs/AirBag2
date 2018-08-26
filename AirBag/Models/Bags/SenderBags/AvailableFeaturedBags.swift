//
//    AvailableFeaturedBag.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class AvailableFeaturedBag : NSObject, Mappable{
    
    var airline : String?
    var availableWeight : Int?
    var carrierRating : AnyObject?
    var departure : String?
    var departureDatetime : String?
    var destination : String?
    var featured : Int?
    var id : Int?
    var kgPrice : Int?
    var views : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AvailableFeaturedBag()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        airline <- map["airline"]
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
