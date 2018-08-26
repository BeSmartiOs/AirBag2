//
//    RootClass.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BagsResponse : NSObject, Mappable{
    
    var availableFeaturedBags : [AvailableFeaturedBag]?
    var availableNormalBags : [AvailableNormalBag]?

    class func newInstance(map: Map) -> Mappable?{
        return BagsResponse()
    }
    
    
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        availableFeaturedBags <- map["availableFeaturedBags"]
        availableNormalBags <- map["availableNormalBags"]
        
    }
    

}
