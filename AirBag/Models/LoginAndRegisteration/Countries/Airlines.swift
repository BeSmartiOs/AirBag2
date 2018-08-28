//
//    RootClass.swift
//
//    Create by Geek on 28/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Airlines : NSObject, Mappable{
    
    var id : Int?
    var name : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Airlines()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        
    }
    
   
}
