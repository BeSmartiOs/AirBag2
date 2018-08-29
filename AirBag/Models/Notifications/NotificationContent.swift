//
//    Content.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class NotificationContent : NSObject,  Mappable{
    
    var notifications : [Notificationss]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return NotificationContent()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        notifications <- map["notifications"]
        
    }
    
    
    
}
