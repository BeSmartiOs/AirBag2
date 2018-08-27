//
//    RootClass.swift
//
//    Create by Geek on 27/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class ItemsInCategResp : NSObject, Mappable{
    
    var active : Int?
    var approved : AnyObject?
    var categoryId : Int?
    var createdAt : String?
    var createdBy : AnyObject?
    var deletedAt : AnyObject?
    var id : Int?
    var name : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ItemsInCategResp()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        active <- map["active"]
        approved <- map["approved"]
        categoryId <- map["category_id"]
        createdAt <- map["created_at"]
        createdBy <- map["created_by"]
        deletedAt <- map["deleted_at"]
        id <- map["id"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
        
    }
    
   
    
}
