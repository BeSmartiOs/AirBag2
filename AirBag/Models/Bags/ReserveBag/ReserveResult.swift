//
//    Result.swift
//
//    Create by Geek on 28/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ReserveResult : NSObject, Mappable{
    
    var messageId : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ReserveResult()
    }
    required init?(map: Map){}
    private override init(){}
    func mapping(map: Map)
    {
        messageId <- map["message_id"]
        
    }
 
    
}
