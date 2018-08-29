//
//    Transaction.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Transactions : NSObject, Mappable{
    
    var avgRating : AnyObject?
    var bagId : Int?
    var carrierName : String?
    var currentTypeId : Int?
    var departure : String?
    var destination : String?
    var itemsCount : Int?
    var receiverName : String?
    var reservedWeight : Int?
    var transactionId : Int?
    var transactionPrice : Int?
    var senderName : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return Transactions()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        avgRating <- map["avg_rating"]
        bagId <- map["bag_id"]
        carrierName <- map["carrier_name"]
        currentTypeId <- map["current_type_id"]
        departure <- map["departure"]
        destination <- map["destination"]
        itemsCount <- map["itemsCount"]
        receiverName <- map["receiver_name"]
        reservedWeight <- map["reserved_weight"]
        transactionId <- map["transaction_id"]
        transactionPrice <- map["transaction_price"]
        senderName <- map["sender_name"]
        
    }
    
   
    
}
