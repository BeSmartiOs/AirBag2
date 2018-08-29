//
//    Content.swift
//
//    Create by Geek on 29/8/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginContentt : NSObject, NSCoding, Mappable{
    
    var active : Int?
    var currentTypeId : Int?
    var nickname : String?
    var token : String?
    var userId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginContentt()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        active <- map["active"]
        currentTypeId <- map["current_type_id"]
        nickname <- map["nickname"]
        token <- map["token"]
        userId <- map["user_id"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        active = aDecoder.decodeObject(forKey: "active") as? Int
        currentTypeId = aDecoder.decodeObject(forKey: "current_type_id") as? Int
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if active != nil{
            aCoder.encode(active, forKey: "active")
        }
        if currentTypeId != nil{
            aCoder.encode(currentTypeId, forKey: "current_type_id")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }
        
    }
    
}
