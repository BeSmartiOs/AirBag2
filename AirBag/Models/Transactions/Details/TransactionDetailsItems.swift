//
//  TransactionDetailsItems.swift
//  AirBag
//
//  Created by Geek on 8/29/18.
//  Copyright © 2018 Geek. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper
class TransactionDetailsItems : NSObject, Mappable{
    
   
    var createdAt : String?
    var descriptionItem  : String?
    var deletedAt : String?
    var height: Int?
    var id : Int?
    var img : String?
    var itemId : Int?
    var itemName : String?
    var itemPrice : Int?
    var length : Int?
    var updatedAt : String?
    var userBagId : Int?
    var weight : Int?
   var  width : Int?
    
    class func newInstance(map: Map) -> Mappable?{
        return TransactionDetailsItems()
    }
    required init?(map: Map){}
    private override init(){}
    
    
   

    
    
    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        descriptionItem <- map["description"]
        height <- map["height"]
        id <- map["id"]
        img <- map["img"]
        itemId <- map["item_id"]
        itemName <- map["item_name"]
        itemPrice <- map["item_price"]
        length <- map["length"]
        updatedAt <- map["updated_at"]
        userBagId <- map["user_bag_id"]
        weight <- map["weight"]
        width <- map["width"]

    }
    
    
}
