//
//    Seen.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class NotificationDetailSeen : NSObject, Mappable{
    
    var date : String?
    var timezone : String?
    var timezoneType : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return NotificationDetailSeen()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        date <- map["date"]
        timezone <- map["timezone"]
        timezoneType <- map["timezone_type"]
        
    }
    

    
}
