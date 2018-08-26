//
//    BagRestriction.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BagRestriction : NSObject, Mappable{
    
    var categoryId : Int?
    var name : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return BagRestriction()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        categoryId <- map["category_id"]
        name <- map["name"]
        
    }

}
