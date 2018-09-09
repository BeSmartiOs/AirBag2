//
//    RootClass.swift
//
//    Create by Geek on 26/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class BagDetialsResp : NSObject, Mappable{
    
    var bagInfo : [BagInfo]?
    var bagRestrictions : [BagRestriction]?
    var reserved : Int?
    
    class func newInstance(map: Map) -> Mappable?{
        return BagDetialsResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bagInfo <- map["bagInfo"]
        bagRestrictions <- map["bagRestrictions"]
        reserved <- map["reserved"]
        
    }
    

}
