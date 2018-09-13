//
//    RootClass.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class NotificationDetailsResp : NSObject, Mappable{
    
    var body : String?
    var createdAt : String?
    var deletedAt : AnyObject?
    var done : Int?
    var id : Int?
    var notificationTypeId : Int?
    var seen : NotificationDetailSeen?
    var title : String?
    var updatedAt : String?
    var userId : Int?
    var userTypeId : Int?
    var transactionId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return NotificationDetailsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        body <- map["body"]
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        done <- map["done"]
        id <- map["id"]
        notificationTypeId <- map["notification_type_id"]
        seen <- map["seen"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        userTypeId <- map["user_type_id"]
        transactionId <- map["transaction_id"]
        
    }

    
}
