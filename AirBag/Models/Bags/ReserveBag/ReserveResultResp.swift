//
//    RootClass.swift
//
//    Create by Geek on 28/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ReserveResultResp : NSObject, Mappable{
    
    var canonicalIds : Int?
    var failure : Int?
    var multicastId : Int?
    var results : [ReserveResult]?
    var success : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ReserveResultResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        canonicalIds <- map["canonical_ids"]
        failure <- map["failure"]
        multicastId <- map["multicast_id"]
        results <- map["results"]
        success <- map["success"]
        
    }

    
}
