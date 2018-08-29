//
//    RootClass.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class TransactionDetailsResp : NSObject, Mappable{
    
    var transaction : [TransactionDetails]?
    var transactionItems : [TransactionDetailsItems]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return TransactionDetailsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        transaction <- map["transaction"]
        transactionItems <- map["transactionItems"]
        
    }
    
    
    
}
