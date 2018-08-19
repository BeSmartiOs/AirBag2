//
//    RootClass.swift
//
//    Create by Geek on 19/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class SuccessResponse : NSObject, Mappable{
    
    var msg : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SuccessResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        msg <- map["msg"]
        
    }
    

    
}
