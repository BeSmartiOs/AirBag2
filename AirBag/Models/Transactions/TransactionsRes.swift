//
//    RootClass.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class TransactionsRes : NSObject, Mappable{
    
    var transactions : [Transactions]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return TransactionsRes()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        transactions <- map["transactions"]
        
    }
    
    
    
}
