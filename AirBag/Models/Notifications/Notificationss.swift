//
//    Notification.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Notificationss : NSObject, Mappable{
    
    var body : String?
    var id : Int?
    var notificationTypeId : Int?
    var seen : String?
    var title : String?
    var userTypeId : Int?
    var bagId : Int?
     var transactionId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Notificationss()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        body <- map["body"]
        id <- map["id"]
        notificationTypeId <- map["notification_type_id"]
        seen <- map["seen"]
        title <- map["title"]
        userTypeId <- map["user_type_id"]
        bagId <- map["bag_id"]
      transactionId  <- map["transaction_id"]
        
    }
    
  
}
