//
//    Transaction.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class TransactionDetails : NSObject, Mappable{
    
    var bagId : Int?
    var carrierName : String?
    var departure : String?
    var departureDatetime : String?
    var departureMobile : AnyObject?
    var destination : String?
    var receiverName : String?
    var reservedWeight : Int?
    var transactionId : Int?
    var transactionPrice : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return TransactionDetails()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bagId <- map["bag_id"]
        carrierName <- map["carrier_name"]
        departure <- map["departure"]
        departureDatetime <- map["departure_datetime"]
        departureMobile <- map["departure_mobile"]
        destination <- map["destination"]
        receiverName <- map["receiver_name"]
        reservedWeight <- map["reserved_weight"]
        transactionId <- map["transaction_id"]
        transactionPrice <- map["transaction_price"]
        
    }
 
    
}
